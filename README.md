### Project overview: 

![image](https://user-images.githubusercontent.com/50198601/212082232-d1fcb701-0cd0-4f5e-99aa-02a5963d0316.png)

The project with ECO-Village in Boekel of Netherland. We were working on to develop the Predictive Data Model to forcast Air Quality Index. With the goal is to support the Eco-Village enhance the ability of using and recommdation option inside the house. 

The air feature is capture from Uhoo machine.

![image](https://user-images.githubusercontent.com/50198601/212082483-52bed104-4d35-4533-bab7-56f1de7c9b30.png)

Technique: 

![image](https://user-images.githubusercontent.com/50198601/212082858-ed028c22-8759-4771-8f95-cd62fa065527.png)

- The AQI calculation uses 7 measures: PM2.5, NOx, NH3, TVOC and CO2.
- For PM2.5, PM10, SO2, NOx and NH3 the average value in last 24-hrs is used with the condition of having at least 16 values. ( in here we do have per minutes of each hour)
- For CO and O the maximum value in last 8-hrs is used. Mainly because the sensor locate inside, it default in 0 index.
- Each measure is converted into a Sub-Index based on pre-defined groups.
- Sometimes measures are not available due to lack of measuring or lack of required data points.
- Sub-index from based index being standardized.
- Final AQI is the maximum Sub-Index with the condition that at least one of PM2.


Sample of Forcasting Data: 

![image](https://user-images.githubusercontent.com/50198601/212080139-5cfc3101-eac0-402e-82d1-df51795ec608.png)

Member: 7 peoples from Netherlands, Belgium, South Africa. 

We applied difference research technique in Data Science, Cyber, Web Development to built a complete data analytic product. 
