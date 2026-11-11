import { chromium } from 'playwright-core'
const browser = await chromium.launch({ executablePath: process.env.CHROME ?? '/usr/bin/google-chrome', headless: true })
const page = await browser.newPage({ viewport: { width: 1400, height: 900 } })
await page.goto('https://adam.math.hhu.de/#/g/emilyriehl/VerboseReintroductionToProofs')
await page.waitForTimeout(8000)
const svg = await page.locator('svg').first().evaluate(e => e.outerHTML).catch(() => 'no svg')
console.log(svg.slice(0, 1500))
console.log('--- classes containing world:', await page.evaluate(() => [...new Set([...document.querySelectorAll('[class*=world]')].map(e => e.tagName + '.' + e.className.baseVal ?? e.className))].slice(0, 12)))
await browser.close()
