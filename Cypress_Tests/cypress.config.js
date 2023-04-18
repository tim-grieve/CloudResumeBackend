const { defineConfig } = require('cypress')
module.exports = defineConfig({
    projectId: "kjixxa",
    e2e: {
        baseUrl: 'https://resume.shellflow.com'
    },
    // The rest of the Cypress config options go here...
})