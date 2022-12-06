# Tracking the Adoption of Electric Vehicles in Washington State
## INFO 201 "Foundational Skills for Data Science" — Spring 2022

Authors:
* Esha Bantwal - ebantwal@uw.edu
* Efra Ahsan - eahsan@uw.edu
* Safa Jamal - safaj03@uw.edu
* Lily Shen - lilyshen@uw.edu

Shiny App: https://j9ivbt-lily-shen.shinyapps.io/final-project-safjam/      
Exploratory Analysis: https://info-201a-sp22.github.io/exploratory-analysis-ebant/

# Introduction

## Questions

The role of vehicles and fuel emissions in climate change has been gaining increasing attention over the past years. Through our analysis we aim to answer the following questions:

* **What are the most efficient electric vehicles based on electric range?**

* **How does the amount of electric vehicles with CAFV vary based on the city?**

* **How does the number of vehicles fluctuate per region?**

We ask such questions because as technology advances and engineers develop more electric vehicles to reduce the amount of carbon dioxide emissions, it’s important to remember that these vehicles still require lots of other energy to function, if not gasoline. Thus, with this project, we will be identifying and collecting data to demonstrate whether electric vehicles are a benefit or harm to the state of Washington.

* **

## The Dataset

In order to answer these questions, we will be using data about electric vehicles in Washington State collected by the DOL.We found this dataset, [Electric Vehicle Population Data](https://data.wa.gov/Transportation/Electric-Vehicle-Population-Data/f6w7-q2d2), in the U.S. Government's open data resource called Data.gov.

* **

## Limitations

One problem with this set is that the 'Electric Range' feature (indicating the distance the vehicle can travel) is no longer maintained, so although some vehicles have data expressing this information, many others do not. Along the same lines, the 'Field Electric Utility' feature (indicating the electric retail service of the vehicle's registered location) was added almost 2 years after this set's initial collection, meaning there is more missing information. A further limitation to this new 'Field Electric Utility' feature is that there's only about a month's worth of information for us to currently see. The inconsistency with the missing data here is a major drawback since there is more information we would need to research ourself and match directly with the data we do have, which is a lot. Additionally, both of these features are researched and manually inputted, such as the Electric Range of a vehicle, so there is room for there to be errors in this manual inputting of information. Lastly, another huge limitation is the dataset does not provide the registration date, so we cannot track the registration of models over a time frame.



# Conclusion / Summary Takeaways


### **What are the most efficient electric vehicles based on electric range?**

Through our visualization about electric efficiency we were able to gain insight into electric range across time and car models:

* The earliest electric vehicle was the Dodge Caravan in 1993, with an electric range of 80. Moreover, *Tesla* has 5 electric vehicles recorded in the data set, with the **most electric efficient** model being the *Model S* with an electric range of **337**. The closest competitor to TESLA is the Chevrolet Bolt EV made in 2017with an electric range of 238.

### **How does the amount of electric vehicles with CAFV vary based on the city?**

The bar plot shows that there are **more** electric vehicles that are **CAFV-eligible than not eligible** in all cities.

* There are some cities -- like **Olympia, WA** -- that have a larger proportion of vehicles that aren’t eligible for CAFV compared to other cities. This could be because Olympia perhaps has more drivers with hybrid vehicles that require gasoline or diesel. It’s also important to note that the chart also shows that a large portion of registered vehicles are categorized as “unknown” because of the low battery range in the vehicle. Thus, we cannot definitively say that Olympia, WA has a larger percentage of non-CAFV vehicles, but we can make assumptions based on the data we have.

Regardless, it seems like a **majority of registered electric vehicles are CAFV-eligible** which is good for our environment.


### **What are the dominating vehicle models throughout Washington state?**

In the top 15 counties, Battery Electric Vehicles (BEV's) show more popularity than Plug-In Hybrid Electric Vehicles (PHEV's). From these vehicles, the top 5 dominating models were:

1. Tesla Model 3
2. Tesla Model Y
3. Nissan Leaf
4. Tesla Model S
5. Tesla Model X

This concludes that **Tesla's dominate the EV population in Washington state.**
* **
Overall, this project allows for Washington state car owners to make more informed decisions what vehicle type they choose to purchase and to identify trends in electric vehicle ownership geographically. Additionally, this analysis may be used by policy makers to determine how Clean Alternative Fuel Vehicle Eligibility can be improved and by car manufacturers to better understand consumer trends in Washington.
