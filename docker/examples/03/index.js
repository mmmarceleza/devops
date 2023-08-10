const http = require('http');
const fs = require('fs');
const path = require('path');

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
			font-size: 100px;
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
`;

function readBackgroundColorFromEnvFile() {
	const envFilePath = path.join(__dirname, '.env');
	let backgroundColor;
	try {
		const envFileContent = fs.readFileSync(envFilePath, 'utf8');
		const envVars = envFileContent.split('\n');
		for (const envVar of envVars) {
			const [key, value] = envVar.split('=');
			if (key === 'BACKGROUND_COLOR') {
				backgroundColor = value;
				break;
			}
		}
	} catch (err) {
		console.error('Error reading .env file:', err);
	}
	return backgroundColor || '#ff0000';
}

const server = http.createServer((req, res) => {
	const backgroundColor = readBackgroundColorFromEnvFile();

	res.setHeader('Content-Type', 'text/html');
	res.write(indexHTML.replace('%s', backgroundColor));
	res.end();
});

const port = 8000;
server.listen(port, () => {
	console.log(`Server started on http://localhost:${port}`);
});

