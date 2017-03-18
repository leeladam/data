# Explanation

#### CSV header
- id  
- year
- month
- day
- hour
- minute
- label (0 = NOT smog, 1 = smog)
- prediction (0 = NOT smog, 1 = smog)
- dataset type (0 = train, 1 = development, 2 = test)

#### Statistics

| Dataset     | # Sum data | # Label 0       | # Label 1      | Accuracy | Precision | Recall  | F-measure |
|-------------|------------|-----------------|----------------|----------|-----------|---------|-----------|
| Train       | 16332      | 8093            | 8239           | 91,58 %  |  90,91 %  | 92,57 % | 0,9173    |
| Development | 5379       | 2682            | 2697           | 80,74 %  |  79,42 %  | 83,13 % | 0,8123    |
| Test        | 13703      | 10985 (80,16 %) | 2718 (19,84 %) | 80,51 %  |  50,52 %  | 84,07 % | 0.6311    |


#### Train

| TRAIN        | True (predicted) | False (predicted) |
|--------------|------------------|-------------------|
| True (gold)  | 7627             | 612               |
| False (gold) | 763              | 7330              |


#### Development

| DEV          | True (predicted) | False (predicted) |
|--------------|------------------|-------------------|
| True (gold)  | 2242             | 455               |
| False (gold) | 581              | 2101              |

#### Test

| TEST         | True (predicted) | False (predicted) |
|--------------|------------------|-------------------|
| True (gold)  | 2285             | 433               |
| False (gold) | 2238             | 8747              |
