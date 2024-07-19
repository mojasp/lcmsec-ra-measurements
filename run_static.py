import os

def main():
    import datetime
    now = datetime.datetime.now()
    now_str = now.strftime("%Y%m%d_%H%M%S")
    testdir = "tracy_run_" + now_str
    os.mkdir(testdir)

    runs_per_player = 1
    max_players=20

    os.system("pkill -9 demo_instance")

    os.system("rm last_run")
    os.system("ln -s " + testdir + " last_run")

    for players in range(1, max_players+1):
        for run in range(1, runs_per_player+1):
            os.system("./run_static_test.sh " + str(players) + " " + str(run) + " " + testdir + " " + "0")

if __name__ == '__main__':
    main()
