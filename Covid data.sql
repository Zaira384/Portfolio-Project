/*select data that we will be using*/
/*SELECT location,date,total_cases,new_cases,total_deaths,population from coviddeaths
order by 1,2*/

/*looking at total cases vs total deaths or Death Percentage*/
/*select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
from coviddeaths
where  date = '1/1/2021' and location like '%ia%'
order by 1,2*/

/*looking at countries with highest infection rate compared to population*/
/*select location,population,max(total_cases) as Highinfectioncount,max((total_cases/population)*100) as Percentpopulationinfected
 from coviddeaths group by location,population order by Percentpopulationinfected*/
 
 /*looking at continents with highest death count per population*/
 /*select location,max(total_deaths) as HighestDeathcount
 from coviddeaths where continent is not null
 group by continent order by HighestDeathcount desc*/
 
 /*Global number, If you want to see overall totalcase remove group by and the column used with group by from the select statement*/
 /*select date,sum(new_cases) as totalcases,sum(new_deaths) as total_deaths,
 sum(new_deaths)/sum(new_cases)*100 as death_percentage from coviddeaths
 where continent is not null
 group by date
 order by death_percentage*/
 
 /*Join two tables*/
 /*select * from coviddeaths d join covidvaccinations v
 where d.iso_code = v.iso_code*/
 
  /*Looking at total population vs vaccination*/


  /*Use CTE*/
  /*with Popvsvac( continent, location,date,population, new_vaccinations,rollingpeoplevaccinated)
  as
  (
  select d.continent,d.location,d.date,d.population,v.new_vaccinations ,
  sum(v.new_vaccinations) over (partition by d.location order by d.location,d.date) 
  as RollingPeopleVaccinated
 from coviddeaths d join covidvaccinations v
 on d.location = v.location and d.date = v.date where d.continent is not null
 order by 2,3
 )
 select * from Popvsvac*/

  
    /*Temp Table*/
/*Drop Table if exists PercentPopulationVaccinated;
Create table PercentPopulationVaccinated
(
  continent nvarchar(255) ,
  location nvarchar(255),
  population int,
  new_vaccinations nchar,
  rollingpeoplevaccinated int
  );
Insert into PercentPopulationVaccinated
select d.continent,d.location,d.population,v.new_vaccinations ,
  sum(v.new_vaccinations) over (partition by d.location order by d.location) 
  as RollingPeopleVaccinated
 from coviddeaths d join covidvaccinations v
 on d.location = v.location  where d.continent is not null
 order by 2,3*/
/* Create view for later*/
 create view PercentPopulationVaccinated2 as select d.continent,d.location,d.population,v.new_vaccinations ,
  sum(v.new_vaccinations) over (partition by d.location order by d.location) 
  as RollingPeopleVaccinated
 from coviddeaths d join covidvaccinations v
 on d.location = v.location  where d.continent is not null
 