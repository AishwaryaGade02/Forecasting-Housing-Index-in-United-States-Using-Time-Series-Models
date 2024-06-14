# Install necessary packages
install.packages("TSA")
library(TSA)
install.packages("forecast")
library(forecast)
install.packages("uroot")
library(uroot)

library(tseries)
# Read the data
exchange <- read.csv("//homes.mtu.edu/home/Documents/TSA/daily-foreign-exchange-rates.csv")
colnames(exchange)[2] <- "Exchange"
#nrow(exchange)
# Convert Exchange column to numeric, coercing errors to NA
#exchange$Exchange <- as.numeric(as.character(exchange$Exchange))

# Identify non-numeric entries (which are now NA)
#non_numeric_indices <- which(is.na(exchange$Exchange))

# Remove non-numeric entries
#exchange <- exchange[-non_numeric_indices, ]

# Create a time series from the cleaned data
data <- ts(exchange$Exchange)
data


plot(data)


# Calculate optimal lambda for Box-Cox transformation
lambda_opt <- BoxCox.lambda(data)
print(lambda_opt)

# Apply the Box-Cox transformation
data_transformed <- BoxCox(data, lambda = lambda_opt)
plot(data_transformed)
plot(diff(data_transformed))
# Check and plot the transformed data
plot(data_transformed, type='o', xlab="Date", ylab="Transformed Data")

## Checking for Stationarity

## ACF Graph
acf(data_transformed)
###Clearly not Stationary
##PACF Graph
pacf(data_transformed)


##Stationary Test
adf.test(data_transformed)
##the p-value (0.409) is greater than the significance levels (0.05). Therefore, we fail to reject the null hypothesis.
## Not Stationary, take difference

adf.test(diff(data_transformed))
##the p-value (0.01) is lesser than the significance levels (0.05). Therefore, we reject the null hypothesis.
## Difference is Stationary, 

## ACF Graph of differece
acf(diff(data_transformed))
## PACF Graph of differece
pacf(diff(data_transformed))
## EACF Graph of differece
eacf(diff(data_transformed))
## ARIMA(1,1,1), IMA(1,1), ARI(1,1)0,1,

arima(data_transformed,order=c(0,1,1),method='ML')
estimate <- 0.0350
std_error <- 0.0145
z_value <- qnorm(0.975)  
lower_bound <- estimate - z_value * std_error
upper_bound <- estimate + z_value * std_error
cat("95% Confidence Interval for ma1: [", lower_bound, ", ", upper_bound, "]\n")

arima(data_transformed, order=c(1,1,0),method='ML')


arima(diff(data_transformed),order=c(1,0,1),method='ML')
estimate <- 0.0175
std_error <- 0.5308
z_value <- qnorm(0.975)  
z_value
lower_bound <- estimate - z_value * std_error
upper_bound <- estimate + z_value * std_error
cat("95% Confidence Interval for ma1: [", lower_bound, ", ", upper_bound, "]\n")

arima(diff(data_transformed),order=c(2,0,0),method='ML')



arima(data_transformed,order=c(2,1,0),method='ML')
estimate1<-0.0350
SE1<-0.0145
lower_bound1 <- estimate1 - z_value * SE1
upper_bound1 <- estimate1 + z_value * SE1

estimate2<--0.0002
SE2<-0.0145
lower_bound2 <- estimate2 - z_value * SE2
upper_bound2 <- estimate1 + z_value * SE2

cat("95% Confidence Interval for ma1: [", lower_bound1, ", ", upper_bound1, "]\n")
cat("95% Confidence Interval for ma1: [", lower_bound2, ", ", upper_bound2, "]\n")

arima(data_transformed,order=c(0,1,2),method='ML')
estimate1<-0.0350
SE1<-0.0145
lower_bound1 <- estimate1 - z_value * SE1
upper_bound1 <- estimate1 + z_value * SE1

estimate2<--0.0005
SE2<-0.0145
lower_bound2 <- estimate2 - z_value * SE2
upper_bound2 <- estimate1 + z_value * SE2

cat("95% Confidence Interval for ma1: [", lower_bound1, ", ", upper_bound1, "]\n")
cat("95% Confidence Interval for ma1: [", lower_bound2, ", ", upper_bound2, "]\n")




res=armasubsets(y=diff(data_transformed),nar=5,nma=5,y.name='diff.temp',ar.method='ols')
plot(res)

# Fit ARIMA(1,1,1) model
arima111_model <- arima(data_transformed, order = c(1, 1, 1), method = 'ML')
arima111_model
is.ts(data_transformed)
length(data_transformed)
# Diagnostic checks
par(mfrow = c(2, 2))
plot(arima111_model$residuals, type = 'o', xlab = "Time", ylab = "Residuals", main = "Residual Plot")
acf(arima111_model$residuals, main = "ACF of Residuals")
pacf(arima111_model$residuals, main = "PACF of Residuals")
qqnorm(arima111_model$residuals, main = "Q-Q Plot of Residuals")
qqline(arima111_model$residuals)
hist(arima111_model$residuals)
# Ljung-Box test
Box.test(arima111_model$residuals, type = "Ljung-Box")
tsdiag(arima111_model,gof=20,omit.initial=F)
# Runs test 
std_resids <- rstandard(arima111_model)

# Check for NA values in the residuals
na_resids <- is.na(std_resids)

# Count the number of NA values
na_count <- sum(na_resids)

# Print the count of missing values
print(na_count)

# Optionally, inspect where the NAs occur
which(na_resids)
runs(rstandard(arima111_model))
rstandard(arima111_model)



install.packages("lawstat")
library(lawstat)

runs.test(rstandard(arima111_model))


# Shapiro test
shapiro.test(rstandard(arima111_model))

# Forecasting
arima111_forecast <- forecast(arima111_model, h = 10)  # Forecast for the next 10 periods
plot(arima111_forecast)

forecast(arima111_model, h = 10)



arima111_model <- arima(data_transformed[1:100], order = c(1, 1, 1), method = 'ML')
arima111_model

forecast(arima111_model, h = 10)





wages <-read.csv("//homes.mtu.edu/home/Documents/TSA/real-daily-wages-in-pounds-engla.csv")
colnames(wages)[2] <- "Wages"


# Create a time series from the cleaned data
data <- ts(wages$Wages, start = c(1260), frequency = 1)
length(data)

plot(data)

# Example dataset



lambda_opt <- BoxCox.lambda(data)
print(lambda_opt)

# Apply the Box-Cox transformation
data_transformed <- BoxCox(data, lambda = lambda_opt)
plot(data_transformed)


## Checking for Stationarity

## ACF Graph
acf(data_transformed)
###Clearly not Stationary
##PACF Graph
pacf(data_transformed)


##Stationary Test
adf.test(data_transformed)
##the p-value (0.409) is greater than the significance levels (0.05). Therefore, we fail to reject the null hypothesis.
## Not Stationary, take difference

adf.test(diff(data_transformed))
##the p-value (0.01) is lesser than the significance levels (0.05). Therefore, we reject the null hypothesis.
## Difference is Stationary, 

## ACF Graph of differece
acf(diff(data_transformed))
## PACF Graph of differece
pacf(diff(data_transformed))
## EACF Graph of differece
eacf(diff(data_transformed))
## Suggests ARMA(2,1) and ARMA(1,3),MA(3). This can be ARIMA(2,1,1) and ARIMA(2,1,2)

res=armasubsets(y=diff(data_transformed),nar=6,nma=6,y.name='diff.temp',ar.method='ols')
#res
plot(res)
#-------------------------------------------------------------------------------------------
arima_im<-arima(data_transformed,order=c(0,1,3),method='ML')
arima_im
z_value <- qnorm(0.975)
ar_estimate1<-0.0597
ar_SE1<-0.0364
ar_lower_bound1 <- ar_estimate1 - z_value * ar_SE1
ar_upper_bound1 <- ar_estimate1 + z_value * ar_SE1

ar_estimate2<--0.1337
ar_SE2<-0.0349
ar_lower_bound2 <- ar_estimate2 - z_value * ar_SE2
ar_upper_bound2 <- ar_estimate2 + z_value * ar_SE2

cat("95% Confidence Interval for ma1: [", ar_lower_bound1, ", ", ar_upper_bound1, "]\n")
cat("95% Confidence Interval for ma1: [", ar_lower_bound2, ", ", ar_upper_bound2, "]\n")
runs.test(rstandard(arima_im))
shapiro.test(rstandard(arima_im))
acf(diff(data_transformed))
pacf(diff(data_transformed))
eacf(diff(data_transformed))
Box.test(residuals(arima_im),lag = 10,type="Ljung-Box",fitdf=1)
#------------------------------------------------------------------------------------------------

arima_ar2ma1<-arima(data_transformed,order=c(2,1,1),method='ML')
arima_ar2ma1
Box.test(residuals(arima_ar2ma1),lag = 10,type="Ljung-Box",fitdf=1)
ma_estimate1<--0.2383
ma_SE1<-0.0365
ma_lower_bound1 <- ma_estimate1 - z_value * ma_SE1
ma_upper_bound1 <- ma_estimate1 + z_value * ma_SE1

ma_estimate2<--0.5452
ma_SE2<-0.1043

ma_lower_bound2 <- ma_estimate2 - z_value * ma_SE2
ma_upper_bound2 <- ma_estimate2 + z_value * ma_SE2


cat("95% Confidence Interval for ma1: [", ma_lower_bound1, ", ", ma_upper_bound1, "]\n")
cat("95% Confidence Interval for ma1: [", ma_lower_bound2, ", ", ma_upper_bound2, "]\n")

#plot(wages)





