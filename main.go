package main

import (
	"fmt"
	"log"
	"net/http"
	"math"
	"strconv"

	"github.com/gorilla/mux"
)

func homeLink(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Home. Gunakan /prime/{number} untuk cek bilangan prima")
}

func checkPrimeNumber(num int) bool {
	if num < 2 {
	   fmt.Println("Number must be greater than 2.")
	   return false
	}
	sq_root := int(math.Sqrt(float64(num)))
	for i:=2; i<=sq_root; i++{
	   if num % i == 0 {
		  return false
	   }
	}
	return true
 }

func primeLink(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	n, err := strconv.Atoi(vars["number"])
	fmt.Println(n, err)
	if err != nil || n < 2 {
		message :=  "Masukan salah."
		fmt.Fprintf(w, message)
	} else if checkPrimeNumber(n) {
		message :=  vars["number"] + " is prime"
		fmt.Fprintf(w, message)
	} else {
		message :=  vars["number"] + " is not prime"
		fmt.Fprintf(w, message)
	}
}

func main() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", homeLink)
	router.HandleFunc("/prime/{number}", primeLink)
	log.Fatal(http.ListenAndServe(":8080", router))
}