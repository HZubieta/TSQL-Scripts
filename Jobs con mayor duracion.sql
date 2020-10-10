SELECT j.name,
	   jh.run_date,
	   jh.run_time,
      (run_duration / 10000) * 3600 +
      ((run_duration % 1000)/ 100) * 60 +
      (run_duration % 100) as total_job_duration_segs
FROM
    msdb.dbo.sysjobs j
INNER JOIN
    msdb.dbo.sysjobhistory jh ON j.job_id = jh.job_id
AND CONVERT(DATETIME, CONVERT(CHAR(8), run_date, 112) + ' '
    + STUFF(STUFF(RIGHT('000000' + CONVERT(VARCHAR(8), run_time), 6), 5, 0, ':'), 3, 0, ':'), 121) > DATEADD(DAY, -7, GETDATE())
AND run_duration > 300
ORDER BY total_job_duration_segs DESC
