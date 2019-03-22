# SeismicAirgun
Lumped parameter seismic air gun code presented in Chelminski, Watson and Ronen (2019) Low frequency pneumatic seismic sources, Geophysical Prospecting, doi: [10.1111/1365-2478.12774](https://doi.org/10.1111/1365-2478.12774)

### What is this repository for? ###

* Modeling a seismic airgun discharging into water, forming a bubble that expands and contracts. The oscillations of the bubble generate pressure perturbations in the water. The code is for far-field pressure perturbations, where there is a direct and a ghost arrival from the reflection from the water surface.

### How do I get set up? ###

* The code is written in MATLAB 
* Run the code by running **AirgunBubbleEval**. The airgun properties, pressure (psi), volume (in^3), and port area (in^2), are specified, in that order, as rows in the matrix A, which is then passed to **AirgunBubbleSolve**. A can have multiple rows corresponding to different firing configurations of the airgun.
* The governing equations are in **modified_herring_eqn**. The modified Herring equation is used to describe the bubble oscillations (see [Vokurka, 1986](http://www.ingentaconnect.com/content/dav/aaua/1986/00000059/00000003/art00010)). Heat conduction effects are taken into account. The airgun is assumed to discharge adiabatically. 
* Parameter values are set by **physical_constants**. The airgun and bubble variables are initialized by **airgun_initialization** and **bubble_initialization**, respectively. If you want to make changes to the parameters and initialization of the solver these are the places to look.

### Who do I talk to? ###

* Leighton: lwat054@stanford.edu
