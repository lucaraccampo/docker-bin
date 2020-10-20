**How to use**

Run `docker-compose build --up` to start sonarqube container.

Login to sonarcube with `admin/admin` credentials.

After that run the following command, remember to change project dir mounted like volume and projectKey with your 
project key defined inside sonarcube.

`docker run --rm -e SONAR_HOST_URL="http://localhost:9000" -v "/Users/luca.raccampo/www/portale-rivenditori-target-web:/usr/src" --network=host sonarsource/sonar-scanner-cli -Dsonar.projectKey=portale-rivenditori-target-web`

You will find the results of analysis in sonarcube dashboard.
