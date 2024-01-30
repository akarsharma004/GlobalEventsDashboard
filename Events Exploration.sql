-- EXPLORATION:

--Exploring event type, sub event type, actor type , trend:

	-- Count of events by disorder type 
	select disorder_type, count(*) as event_count
	from events group by disorder_type --Events due to political violence and demosntrations are higher in number

	--Sub_event count for each event type
	select event_type, sub_event_type, count(*) as event_count 
	from events group by 1,2 order by event_type , event_count desc

	--Actor responsible for each type of event
	select actor_type, count(*) from events group by actor_type --Protest are the most occuerin event

	--Actor responsible for each sub_event
	select actor_type, sub_event_type, count(*) as event_count 
	from events group by 1,2 order by actor_type , event_count desc

	--Year with most event
	select extract(year from event_date)as year , count(*)
	from events group by year order by count(*) desc --2023 and 2022 are the year with most events

	--No. of different event in each year
	select extract(year from event_date) as yr,event_type,count(*) 
	from events group by  event_type ,yr
	order by yr, count(*) desc

	--Events over the month
	select extract(month from event_date) as mnth,count(*)
	from events group by mnth order by count(*) desc -- october been the month with most event

	-- Event occuring in month of october
	select event_type,count(*) from events
	where extract(month from event_date) = 10
	group by  event_type order by count(*) desc --Protests , Explosions are the most occuring event

--Exploring fatalities and civilian target during an event.

	--Fatalities in each type of event
	select event_type, count(fatalities) 
	from events e inner join details d on e.event_id = d.event_id
	group by event_type order by count(fatalities)

	--No. of civilian targeted in each event type
	select event_type,civilian_target, count(*) 
	from events e inner join details d on e.event_id = d.event_id
	group by event_type, civilian_target order by event_type,count(*)

--Exploring events location

	--No. of event by region
	select region, count(*) as event_count
	from locations group by region order by event_count desc

	--Top countries by region with most event
	select region,country, count(*) as event_count
	from locations group by region,country order by region, event_count desc

	--Region with most fatalities 
	select region, count(*)
	from locations l join details d on l.loc_id = d.loc_id
	group by region order by count(*) desc

	--Region with civilian targeting  
	select region,civilian_target, count(*)
	from locations l inner join details d on l.loc_id = d.loc_id
	group by region,civilian_target order by count(*) desc

	--Events by regions
	select region , event_type, count(*)
	from locations l inner join events e on l.event_id = e.event_id
	group by region, event_type order by count(*)  desc


