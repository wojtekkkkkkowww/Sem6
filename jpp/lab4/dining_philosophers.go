// implementation of dining philosophers in go language 

package main

import (
    "fmt"
    "sync"
    "time"
	"os"
	"strconv"
)


type Fork struct{ sync.Mutex }

type Philosopher struct {
    id             int
    leftFork, rightFork *Fork
}

func (p Philosopher) start(wg *sync.WaitGroup, NumMeals int) {
    var lastMeal  = time.Now()
	var currentTime = time.Now()
	var timeElapsed time.Duration

	
	for i := 0; i < NumMeals; i++ {
        fmt.Printf("%d Rozmysla %d\n", p.id + 1, i + 1)
		// czas na rozmyslanie
		time.Sleep(time.Millisecond )

		p.leftFork.Lock()
		fmt.Printf("%d Podnosi lewy \n", p.id + 1)
        p.rightFork.Lock()
		fmt.Printf("%d Podnosi prawy \n", p.id + 1)

		currentTime = time.Now()
		timeElapsed = currentTime.Sub(lastMeal)
		
		for timeElapsed > time.Millisecond * 6 {
			fmt.Printf("%d Umarl z glodu\n", p.id + 1)
			fmt.Printf("Time elapsed: %f \n", timeElapsed.Seconds())
		}

        fmt.Printf("%d Je %d\n", p.id+1,i+1)
        // czas na jedzenie
		time.Sleep(time.Millisecond )
		lastMeal = time.Now()

        p.rightFork.Unlock()
		fmt.Printf("%d Odklada prawy \n", p.id + 1)
        p.leftFork.Unlock()
		fmt.Printf("%d Odklada lewy \n", p.id + 1)

    }
    wg.Done()
}

func main() {
    NumPhilosophers, _ := strconv.Atoi(os.Args[1])
	NumMeals, _ := strconv.Atoi(os.Args[2])

	var wg sync.WaitGroup
    wg.Add(NumPhilosophers)

	
    forks := make([]*Fork, NumPhilosophers)
    for i := 0; i < NumPhilosophers; i++ {
        forks[i] = &Fork{}
    }

    philosophers := make([]*Philosopher, NumPhilosophers)
    for i := 0; i < NumPhilosophers; i++ {
        if i % 2 == 0 {
			philosophers[i] = &Philosopher{
				id: i, 
				leftFork: forks[(i+1)%NumPhilosophers], 
				rightFork: forks[i],
			}
		}else{
			philosophers[i] = &Philosopher{
				id: i, 
				leftFork: forks[i], 
				rightFork: forks[(i+1)%NumPhilosophers],
			}
		}
		
		go philosophers[i].start(&wg, NumMeals)
    }

    wg.Wait()
}