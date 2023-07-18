### Project overview: 

![image](https://user-images.githubusercontent.com/50198601/212082232-d1fcb701-0cd0-4f5e-99aa-02a5963d0316.png)

This project focuses on the development of a Predictive Data Model for the Air Quality Index (AQI) at the ECO-Village in Boekel, Netherlands. The primary aim is to enhance the living environment within the village by offering data-informed recommendations for air quality management.

Data for this project is captured through an uHoo air quality device, which provides continuous monitoring of various air pollutants.

The air feature is capture from Uhoo machine.

![image](https://user-images.githubusercontent.com/50198601/212082483-52bed104-4d35-4533-bab7-56f1de7c9b30.png)

## Technical Approach

![image](https://user-images.githubusercontent.com/50198601/212082858-ed028c22-8759-4771-8f95-cd62fa065527.png)

Each measure is converted into a Sub-Index based on pre-defined groups. The final AQI is then calculated as the maximum Sub-Index, with the prerequisite that at least one of PM2.5, PM10, SO2, NOx and NH3 measures is available.

In cases where measurements are not available due to either a lack of measurement or insufficient data points, the system allows for this limitation by utilizing the most recent, valid data. The project also takes into account that some measures, such as CO and O, are typically at an index of 0 when measured indoors, and thus the maximum value from the last 8 hours is used for these particular components.

- The AQI calculation uses 7 measures: PM2.5, NOx, NH3, TVOC and CO2.
- For PM2.5, PM10, SO2, NOx and NH3 the average value in last 24-hrs is used with the condition of having at least 16 values. ( in here we do have per minutes of each hour)
- For CO and O the maximum value in last 8-hrs is used. Mainly because the sensor locate inside, it default in 0 index.
- Each measure is converted into a Sub-Index based on pre-defined groups.
- Sometimes measures are not available due to lack of measuring or lack of required data points.
- Sub-index from based index being standardized.
- Final AQI is the maximum Sub-Index with the condition that at least one of PM2.


## Forcasting Data: 

![image](https://user-images.githubusercontent.com/50198601/212080139-5cfc3101-eac0-402e-82d1-df51795ec608.png)

## Team Composition

The project team was composed of seven members from the Netherlands, Belgium, and South Africa. Our interdisciplinary team comprised of experts in the fields of Data Science, Cybersecurity, and Web Development. This diverse skill set allowed us to develop a comprehensive data analytics product that integrates various technological techniques and strategies.

This project stands as an example of effective interdisciplinary collaboration, combining expertise in data science, web development, and cybersecurity to build an impactful data-driven solution for enhancing air quality in living environments.

Contributions to this repository are welcomed and appreciated. For any queries or further discussion, please raise an issue or submit a pull request.
