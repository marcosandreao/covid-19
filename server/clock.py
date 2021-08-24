from apscheduler.schedulers.blocking import BlockingScheduler
import brazil_total

sched = BlockingScheduler()


@sched.scheduled_job('interval', hours=12)
def scheduled_job():
    print('CRON: brazil_total start')
    brazil_total.run()
    print('CRON: brazil_total end')


sched.start()
