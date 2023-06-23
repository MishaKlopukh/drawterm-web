const express = require('express'),
    path = require('path'),
    enableWs = require('express-ws'),
    net = require('net'),
    url = require('url')

const app = express()

app.use('/', express.static(path.join(path.join(__dirname, '..'), 'dist')))

enableWs(app)
app.ws('/wsproxy', (client, req) => {
    const u = url.parse(req ? req.url : client.upgradeReq.url, true)
    const target_host = u.query.host
    const target_port = parseInt(u.query.port)

    console.log('proxying to ' + target_host + ':' + target_port)

    var target = net.createConnection(target_port, target_host)
    console.log('target created')
    target.on('data', function (data) {
        try {
            console.log('target data')
            client.send(data)
        } catch (e) {
            target.end()
        }
    })
    target.on('end', function () {
        console.log('target end')
        client.close()
    })
    target.on('error', function () {
        target.end()
        client.close()
    })

    client.on('message', function (msg) {
        console.log('client message')
        target.write(msg)
    })
    client.on('close', function (code, reason) {
        console.log('client close')
        target.end()
    })
    client.on('error', function (a) {
        target.end()
    })
})

app.listen(3000)
