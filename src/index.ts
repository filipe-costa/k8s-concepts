import express from "express"
import log4js from "log4js"

log4js.configure({
    appenders: {
        chi: {
            type: "file", 
            filename: "/var/logs/chi.log",
            maxLogSize: 10485760, 
            backups: 3, 
            compress: true
        }
    },
    categories: {
        default: {
            appenders: ["chi"],
            level: "info"
        }
    }
})

const logger = log4js.getLogger("chi")
const app = express()

app.get("/healthz", (_, res) => {
    logger.info("Ping")
    res.sendStatus(200)
})

app.listen(3000, () => {
    console.log(`Listening on http://localhost:3000`)
})