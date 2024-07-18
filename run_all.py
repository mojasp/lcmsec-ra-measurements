import os

def main():
    import datetime
    now = datetime.datetime.now()
    now_str = now.strftime("%Y%m%d_%H%M%S")
    testdir = "tracy_run_" + now_str
    os.mkdir(testdir)

    runs_per_player = 1
    max_players=15

    os.system("pkill -9 demo_instance")

    os.system("rm last_run")
    os.system("ln -s " + testdir + " last_run")

    setup=0 # start with an existing group of size 10

    #iterate from 0 to max_players
    for setup in [0, 5, 10, 15, 20]:
        current_dir=testdir + "/p" + str(setup)
        print(current_dir)
        os.mkdir(current_dir)
        for players in range(1, max_players+1):
            for run in range(1, runs_per_player+1):
                os.system("./run_test.sh " + str(players) + " " + str(run) + " " + current_dir + " " + str(setup))

if __name__ == '__main__':
    main()
