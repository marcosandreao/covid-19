from apscheduler.schedulers.blocking import BlockingScheduler
import brazil_total

sched = BlockingScheduler()


@sched.scheduled_job('interval', minutes=30)
def timed_job():
    print('CRON: service is ON.')


@sched.scheduled_job('cron', hour=3)
def scheduled_job():
    print('CRON: brazil_total start')
    brazil_total.run()
    print('CRON: brazil_total end')


sched.start()
