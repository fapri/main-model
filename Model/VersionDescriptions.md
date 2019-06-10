
# Trigger Scripts

#### TrailingStop: 
Our base model. When the price passes through a baseline, a sale is triggered

#### TrailingStopV3: 
A new marketing year, "Marketing Year Adjusted" is created where new baselines are calculated at 1% lower than the FAPRI baselines. Sales are triggered when the market passes through these new baselines.

# Actualization Scripts

#### PriceObjectiveActualized: 
10% Sales

#### PriceObjectiveActualizedV2: 
20% Sales at 90th percentile

#### TrailingStopActualized: 
10% Sales

#### TrailingStopActualizedV2: 
20% Sales at 90th percentile

#### TrailingStopActualizedV3: ARCHIVED
20% Sales at 90th percentile, 3 day buffer, Current percentile must be lower than percentiles for last 3 days

#### TrailingStopActualizedV4: ARCHIVED
20% Sales at 90th percentile, 5% drop from baselines

#### TrailingStopActualizedV5: 
July 20th dump date (June for Corn), each TS sale is at 20% of whatever is on Sept 1st. (ex. if 50% of crop remains, TS sales will be made at 10%) 

#### TrailingStopActualizedV6: 
10% Sales, July 20th dump date    

#### TrailingStopActualizedV7: 
20% Sales at 90th percentile, July 20th dump date