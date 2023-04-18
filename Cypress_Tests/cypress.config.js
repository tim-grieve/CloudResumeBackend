const { defineConfig } = require('cypress')
module.exports = defineConfig({
    projectId: "kjixxa",
    e2e: {
        baseUrl: 'https://resume.shellflow.com',
        supportFile: false
    },
    integrationFolder: "./integration",
    // The rest of the Cypress config options go here...
})