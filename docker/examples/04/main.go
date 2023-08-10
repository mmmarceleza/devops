// main.go

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"
)

const indexHTML = `
<!DOCTYPE html>
<html>
<head>
	<title>Hello World</title>
	<style>
		body {
			margin: 0;
			padding: 0;
			--background-color: %s;
			background-color: var(--background-color);
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
			font-size: 24px;
			color: white;
		}
	</style>
</head>
<body>
	<div>Hello World</div>

	<script>
		function updateBackgroundColor() {
			const helloWorldElement = document.querySelector('body');
			helloWorldElement.style.backgroundColor = getComputedStyle(helloWorldElement).getPropertyValue('--background-color');
		}

		// Call the updateBackgroundColor function initially
		updateBackgroundColor();

		// Periodically check for changes in the BACKGROUND_COLOR variable and update the background color
		setInterval(updateBackgroundColor, 1000);
	</script>
</body>
</html>
`

func readBackgroundColorFromEnvFile() (string, error) {
	envFilePath := filepath.Join("/app", ".env")
	content, err := os.ReadFile(envFilePath)
	if err != nil {
		return "", err
	}

	// Split lines and find the BACKGROUND_COLOR
	lines := strings.Split(string(content), "\n")
	for _, line := range lines {
		parts := strings.SplitN(line, "=", 2)
		if len(parts) == 2 && parts[0] == "BACKGROUND_COLOR" {
			return strings.TrimSpace(parts[1]), nil
		}
	}

	return "", fmt.Errorf("BACKGROUND_COLOR not found in .env file")
}

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
	backgroundColor, err := readBackgroundColorFromEnvFile()
	if err != nil {
		log.Printf("Error reading .env file: %v\n", err)
		// Default background color (red) if .env file cannot be read or the value is empty
		backgroundColor = "#ff0000"
	}

	// Set the Content-Type header to serve HTML
	w.Header().Set("Content-Type", "text/html")

	// Format the HTML page with the correct background color and send it as the response
	html := fmt.Sprintf(indexHTML, backgroundColor)
	fmt.Fprint(w, html)
}

func main() {
	http.HandleFunc("/", helloWorldHandler)

	port := "8000"
	log.Printf("Server started on http://localhost:%s\n", port)
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal(err)
	}
}

