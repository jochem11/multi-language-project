package main

import (
	"log"
	"net/http"
)

func main() {
	log.Println("Hello from graphql-gatewfefefay")

	http.HandleFunc("/health", func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("ok"))
	})

	log.Fatal(http.ListenAndServe(":8081", nil))
}
