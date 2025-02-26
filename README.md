## Time Series Analysis: Predicting Housing Index in the United States

### Project Objective
The goal of this project is to conduct a Time Series Analysis on the United States Housing Price Index (HPI) using data from the Federal Housing Finance Agency (FHFA). The objective is to analyze historical trends, apply statistical modeling techniques, and forecast future housing prices

### Dataset
**Source** : Federal Housing Finance Agency (FHFA) <br/>
**Time Period** : January 1991 - April 2013 <br/>
**Sampling Frequency** : Monthly observations <br/>
**Number of Observations Used** : First 80 samples (January 1991 - July 1997) for model building <br/>

### Objectives
1. Identify a suitable time series model for forecasting the U.S. Housing Price Index
2. Generate predictions for the next five years based on the selected model

### Methodology
#### Data Preprocessing
- The dataset was preprocessed to remove unnecessary attribute
- Stationarity was checked using Augmented Dickey-Fuller (ADF) test
- Differencing was applied to achieve stationarity
- Autocorrelation Function (ACF) and Partial Autocorrelation Function (PACF) plots were analyzed to determine model order

#### Model Selection
Two models were considered from the EACF analysis:
1. ARI(1,1) Model (AutoRegressive Integrated Model)
2. IMA(1,1) Model (Integrated Moving Average Model)

- Parameter estimation was performed using Maximum Likelihood Estimation (MLE)
- Model assumptions (independence, normality, adequacy) were validated through
  - Shapiro-Wilk Test (Normality Check)
  - Runs Test (Independence Check)
  - Ljung-Box Test (Model Adequacy Check)
 #### Model Comparison 
 | Model    | Parameter Estimate | Standard Error | AIC   | Normality | Independence | Adequacy |
|----------|-------------------|---------------|-------|-----------|--------------|----------|
| ARI(1,1) | 0.6486            | 0.0858        | 37.89 | ✅ Pass    | ✅ Pass      | ✅ Pass  |
| IMA(1,1) | 0.5070            | 0.0879        | 53.24 | ✅ Pass    | ✅ Pass      | ❌ Fail  |

- Since ARI(1,1) passed all diagnostics, it was selected as the final model
#### Forecasting
- The ARI(1,1) model was used to predict HPI for the next 10 months (September 1997 - June 1998)
- Prediction intervals were calculated for each forecasted value

#### Forecasted Results
| Date       | Predicted HPI | Lower PI | Upper PI |
|------------|--------------|----------|----------|
| 1997-09-01 | 120.959      | 120.366  | 121.553  |
| 1997-10-01 | 121.128      | 119.984  | 122.271  |
| 1997-11-01 | 121.237      | 119.559  | 122.915  |
| 1997-12-01 | 121.308      | 119.129  | 123.486  |
| 1998-01-01 | 121.354      | 118.712  | 123.995  |
| 1998-02-01 | 121.383      | 118.314  | 124.452  |
| 1998-03-01 | 121.403      | 117.939  | 124.867  |
| 1998-04-01 | 121.415      | 117.585  | 125.246  |
| 1998-05-01 | 121.423      | 117.251  | 125.596  |
| 1998-06-01 | 121.429      | 116.936  | 125.921  |


#### Key Findings & Insights
- The ARI(1,1) model effectively captures the trend in the U.S. Housing Price Index

- The predicted values align closely with actual observed values

- Forecast uncertainty increases over time, as indicated by the widening prediction intervals

- The model suggests a gradual increase in housing prices, assuming economic conditions remain constant

 #### Limitations
- The model was trained on only 80 data points, limiting its predictive power for long-term forecasting.

- External factors such as economic policies, inflation, mortgage rates, and housing supply were not included in the model.

- Future improvements can include more advanced models (e.g., ARIMA, LSTM) and external economic indicators for better accuracy

#### Technologies Used
- Programming Language: R

- Libraries: forecast, tseries, stats

- Statistical Methods: ADF Test, Maximum Likelihood Estimation, Ljung-Box Test

#### References
1. Case, K. E., & Shiller, R. J. (2003). Is there a bubble in the housing market? Brookings Papers on Economic Activity.

2. Green, R., & Hendershott, P. H. (1996). Age, housing demand, and real house prices. Regional Science and Urban Economics.

3. Rapach, D. E., & Strauss, J. K. (2009). Differences in housing price forecastability across U.S. states. International Journal of Forecasting.

4. Olick, D. (2021). Home prices in July see the biggest jump in 17 years. CNBC.

5. U.S. Bureau of Economic Analysis. Table 2.4.5U: Personal Consumption Expenditure


 
