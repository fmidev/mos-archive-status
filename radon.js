const Pool = require('pg').Pool
const pool = new Pool({
  user: process.env.MOS_ARCHIVE_USER,
  host: process.env.MOS_ARCHIVE_HOST,
  database: process.env.MOS_ARCHIVE_DATABASE,
  password: process.env.MOS_ARCHIVE_PASSWORD,
  port: process.env.MOS_ARCHIVE_PORT
})
const getData = (request, response) => {
  var query = 'SELECT * FROM mos_archive_status'

  if (request.params.year !== undefined) {
    const year = parseInt(request.params.year)
    const start = Date.UTC(year, 0, 1, 0, 0, 0) / 1000
    const stop = Date.UTC(year+1, 0, 1, 0, 0, 0) / 1000

    query += " WHERE origintime >= " + start + " AND origintime < " + stop
  }
  pool.query(query, (error, results) => {
    if (error) { throw error }
  response.status(200).json(results.rows)
  })
}

module.exports = { getData }
