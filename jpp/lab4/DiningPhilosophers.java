import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

class Fork {
    private boolean isTaken = false;

    synchronized void pickUp() throws InterruptedException {
        while (isTaken) {
            wait();
        }
        isTaken = true;
    }

    synchronized void putDown() {
        isTaken = false;
        notify();
    }
}


class Philosopher extends Thread {
    private final int id;
    private final Fork leftFork;
    private final Fork rightFork;
    private final int numMeals;
    private final CountDownLatch latch;

    Philosopher(int id, Fork leftFork, Fork rightFork, int numMeals, CountDownLatch latch) {
        this.id = id;
        this.leftFork = leftFork;
        this.rightFork = rightFork;
        this.numMeals = numMeals;
        this.latch = latch;
    }

    public void run() {
        for (int i = 0; i < numMeals; i++) {
            try {
                System.out.printf("%d Rozmysla %d\n", id + 1, i + 1);
                Thread.sleep(1);  // czas na rozmyslanie

                leftFork.pickUp();
                System.out.printf("%d Podnosi lewy \n", id + 1);

                rightFork.pickUp();
                System.out.printf("%d Podnosi prawy \n", id + 1);

                System.out.printf("%d Je %d\n", id + 1, i + 1);

                rightFork.putDown();
                System.out.printf("%d Odklada prawy \n", id + 1);

                leftFork.putDown();
                System.out.printf("%d Odklada lewy \n", id + 1);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        latch.countDown();  
    }
}

public class DiningPhilosophers {
    public static void main(String[] args) {
        int numPhilosophers = Integer.parseInt(args[0]);
        int numMeals = Integer.parseInt(args[1]);

        CountDownLatch latch = new CountDownLatch(numPhilosophers);

        Fork[] forks = new Fork[numPhilosophers];
        for (int i = 0; i < numPhilosophers; i++) {
            forks[i] = new Fork();
        }

        Philosopher[] philosophers = new Philosopher[numPhilosophers];
        for (int i = 0; i < numPhilosophers; i++) {
            if (i % 2 == 0) {
                philosophers[i] = new Philosopher(i, forks[(i + 1) % numPhilosophers], forks[i], numMeals, latch);
            } else {
                philosophers[i] = new Philosopher(i, forks[i], forks[(i + 1) % numPhilosophers], numMeals, latch);
            }
            philosophers[i].start();
        }

        try {
            latch.await();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}