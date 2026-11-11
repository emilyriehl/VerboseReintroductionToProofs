// Plays the Verbose game in a real (headless) Chrome through the local lean4game dev server,
// level by level, typing the recorded sample inputs into the typewriter exactly as a player would.
// Checks per level: the typewriter appears, no "Crashed!" banner, every sentence is accepted,
// "Level completed" shows, the Next button is enabled. Writes report.md and screenshots on failure.
//
// usage: node playthrough.mjs [WorldA,WorldB,...] [--from=World:level] [--to=World:level] [--headed]
// env: BASE (dev server, default http://localhost:3000), GAME (default local/VerboseReintroductionToProofs),
//      GAME_DIR (default: this repository), CHROME (default /usr/bin/google-chrome), DEBUG=1, SHOTS=1, LOAD_ONLY=1, NO_MAP=1
import { chromium } from 'playwright-core'
import fs from 'node:fs'
import path from 'node:path'

const BASE = process.env.BASE ?? 'http://localhost:3000'
const GAME = process.env.GAME ?? 'local/VerboseReintroductionToProofs'
const GAME_DIR = process.env.GAME_DIR ?? path.resolve(path.dirname(new URL(import.meta.url).pathname), '..', '..')
const TESTS = path.join(GAME_DIR, 'tests', 'replays')
const HERE = path.dirname(new URL(import.meta.url).pathname)
const ORDER = [['TypeWorld','T'],['FunctionWorld','F'],['ImplicationWorld','I'],['ProductWorld','P'],['ConjunctionWorld','K'],
  ['CoproductWorld','C'],['DisjunctionWorld','D'],['EmptyWorld','E'],['NegationWorld','N'],['ClassicalWorld','L'],['EqualityWorld','Q'],
  ['BooleanWorld','B'],['QuantifierWorld','U'],['AdvancedFunctionWorld','A'],['EquivalenceWorld','V'],['NaturalNumbersWorld','M'],['DependentWorld','W']]
const args = process.argv.slice(2)
const only = args.find(a => !a.startsWith('--'))?.split(',')
const from = args.find(a => a.startsWith('--from='))?.slice(7)
const to = args.find(a => a.startsWith('--to='))?.slice(5)
let stopAll = false
const headed = args.includes('--headed')
const game = JSON.parse(fs.readFileSync(path.join(GAME_DIR, '.lake/gamedata/game.json'), 'utf8'))

function inputFor(letter, n) {
  const exact = path.join(TESTS, `${letter}${n}.txt`)
  if (fs.existsSync(exact)) return exact
  const alt = fs.readdirSync(TESTS).filter(f => new RegExp(`^${letter}${n}[a-z]\\.txt$`).test(f)).sort()[0]
  return alt ? path.join(TESTS, alt) : null
}

const browser = await chromium.launch({ executablePath: process.env.CHROME ?? '/usr/bin/google-chrome', headless: !headed })
const context = await browser.newContext({ viewport: { width: 1400, height: 900 } })
const page = await context.newPage()
const consoleErrors = []
const t0 = Date.now()
page.on('pageerror', e => consoleErrors.push(`pageerror: ${e.message}`))
page.on('console', m => { if (m.type() === 'error' || (process.env.DEBUG && /proof state summary|loadGoals|sending rpc request/.test(m.text()))) consoleErrors.push(`[${((Date.now() - t0) / 1000).toFixed(1)}s] ` + m.text().slice(0, 300)) })

const results = []
const stamp = () => `${((Date.now() - t0) / 1000).toFixed(0)}s`

async function textOf(sel) { return (await page.locator(sel).allInnerTexts()).join('\n') }
async function crashed() { return (await page.locator('.crashed_message').count()) > 0 }
async function waitIdle(timeout = 60000) {
  // the submit button is disabled while the server processes a line
  const btn = page.locator('.typewriter button[type=submit]')
  await page.waitForFunction(() => { const b = document.querySelector('.typewriter button[type=submit]'); return b && !b.disabled }, null, { timeout }).catch(() => {})
  return btn
}

let started = !from
for (const [world, letter] of ORDER) {
  if (only && !only.includes(world)) continue
  const size = game.worldSize?.[world] ?? 0
  for (let n = 1; n <= size; n++) {
    if (stopAll) break
    if (!started) { if (`${world}:${n}` === from) started = true; else continue }
    if (to && `${world}:${n}` === to) stopAll = true
    const input = inputFor(letter, n)
    const r = { world, level: n, input: input && path.basename(input), status: 'PASS', notes: [], steps: [] }
    results.push(r)
    const url = `${BASE}/#/g/${GAME}/world/${world}/level/${n}`
    const fail = async (why) => {
      r.status = 'FAIL'; r.notes.push(why)
      const shot = path.join(HERE, 'shots', `${world}-${n}.png`)
      await page.screenshot({ path: shot, fullPage: true }).catch(() => {})
      console.log(`  FAIL ${world} ${n}: ${why}`)
    }
    try {
      console.log(`[${stamp()}] ${world} level ${n} (${r.input ?? 'no input'})`)
      const tLoad = Date.now()
      await page.goto(url)
      // the typewriter (a Monaco editor) must appear and the server must answer
      await page.locator('.typewriter-input .monaco-editor').first().waitFor({ timeout: 90000 })
      await waitIdle(90000)
      await page.waitForTimeout(500)
      if (await crashed()) await fail('Crashed banner on level load: ' + (await textOf('.crashed_message')).slice(0, 160))
      r.loadSeconds = ((Date.now() - tLoad) / 1000).toFixed(1)
      const phase = (what) => { if (process.env.DEBUG) console.log(`    [${stamp()}] ${what}`) }
      phase(`loaded in ${r.loadSeconds}s`)
      if (!input || process.env.LOAD_ONLY) { r.notes.push(`loaded in ${r.loadSeconds}s` + (input ? '' : '; no recorded input')); continue }
      const lines = fs.readFileSync(input, 'utf8').split('\n').filter(l => l.trim())
      for (const line of lines) {
        const tStep = Date.now()
        await page.locator('.typewriter-input .monaco-editor .view-lines').first().click()
        await page.keyboard.type(line)
        await page.keyboard.press('Enter')
        await page.waitForTimeout(300)
        await waitIdle(60000)
        await page.waitForTimeout(300)
        const dt = ((Date.now() - tStep) / 1000).toFixed(1)
        const errs = await page.locator('.proof .error, .proof .message.error, .typewriter .error').allInnerTexts().catch(() => [])
        const errText = errs.map(e => e.trim()).filter(Boolean).join(' | ').slice(0, 200)
        r.steps.push({ line, seconds: dt, error: errText || undefined })
        phase(`step "${line}" took ${dt}s`)
        if (await crashed()) { await fail(`Crashed after "${line}": ` + (await textOf('.crashed_message')).slice(0, 160)); break }
        if (errText) { await fail(`error after "${line}": ${errText}`); break }
      }
      if (process.env.SHOTS) await page.screenshot({ path: path.join(HERE, 'shots', `${world}-${n}-end.png`) }).catch(() => {})
      if (r.status === 'PASS') {
        const done = await page.getByText('Level completed', { exact: false }).first().waitFor({ timeout: 30000 }).then(() => true).catch(() => false)
        phase(`completion wait done=${done}`)
        if (!done) await fail('no "Level completed" after the last sentence')
        else {
          // older clients (adam) render Next differently; don't wait 30 s for a button that isn't there
          const next = page.getByRole('button', { name: /next/i }).first()
          const disabled = await next.isDisabled({ timeout: 3000 }).catch(() => null)
          phase(`next button checked (disabled=${disabled})`)
          if (disabled) await fail('Next button disabled although the level is completed')
        }
      }
    } catch (e) {
      await fail(`exception: ${String(e.message || e).slice(0, 200)}`)
    } finally {
      // progress survives an interrupted run
      fs.appendFileSync(path.join(HERE, 'progress.log'), `${new Date().toISOString()} ${r.status} ${world} ${n} load=${r.loadSeconds ?? '?'}s ${r.notes.join('; ')}\n`)
    }
  }
}
// World map: which worlds are locked now? (exercises the world-unlock logic of the client)
if (!process.env.NO_MAP) {
  try {
    await page.goto(`${BASE}/#/g/${GAME}`)
    await page.locator('.world-circle').first().waitFor({ timeout: 60000 })
    await page.waitForTimeout(1500)
    // Two client generations: `a.world.disabled` wrappers, or bare circles whose fill encodes the
    // state (green = completed, blue = unlocked, grey = locked). Titles sit in a foreignObject at
    // the same coordinates as the circle.
    const worlds = await page.evaluate(() => {
      const anchors = [...document.querySelectorAll('a.world')]
      if (anchors.length) return anchors.map(a => ({ title: a.querySelector('.world-title')?.textContent?.trim(), state: a.classList.contains('disabled') ? 'locked' : 'open' }))
      const titles = [...document.querySelectorAll('foreignObject')].map(f => ({ x: f.getAttribute('x'), y: f.getAttribute('y'), title: f.querySelector('.world-title')?.textContent?.trim() }))
      return [...document.querySelectorAll('.world-circle')].map(c => {
        const t = titles.find(t => t.x === c.getAttribute('cx') && t.y === c.getAttribute('cy'))
        return { title: t?.title, fill: c.getAttribute('fill') }
      })
    })
    results.push({ world: 'WorldMap', level: 0, input: null, status: 'INFO', notes: [JSON.stringify(worlds)], steps: [] })
    console.log('world map:', JSON.stringify(worlds))
  } catch (e) { console.log('world map check failed: ' + String(e.message || e).slice(0, 120)) }
}
await browser.close()

const lines = [`# Playthrough report (${new Date().toISOString()})`, '',
  `Levels: ${results.length}, passed: ${results.filter(r => r.status === 'PASS').length}, failed: ${results.filter(r => r.status === 'FAIL').length}`, '']
for (const r of results) {
  const slow = r.steps.filter(s => Number(s.seconds) > 8).map(s => `${s.seconds}s for "${s.line}"`)
  lines.push(`- ${r.status} ${r.world} ${r.level} (${r.input ?? '-'})${r.notes.length ? ': ' + r.notes.join('; ') : ''}${slow.length ? ' [slow: ' + slow.join(', ') + ']' : ''}`)
}
lines.push('', '## Console errors (deduplicated)', '', ...[...new Set(consoleErrors)].slice(0, 40).map(e => '- ' + e))
fs.writeFileSync(path.join(HERE, 'report.md'), lines.join('\n') + '\n')
console.log(`\nreport: ${path.join(HERE, 'report.md')}`)
