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

#### Stat

| Dataset     | # Sum data | # Label 0       | # Label 1      | Accuracy | Precision | Recall |
|-------------|------------|-----------------|----------------|----------|-----------|--------|
| Train       | 16332      | 8093            | 8239           | 91,58 %  |           |        |
| Development | 5379       | 2682            | 2697           | 80,74 %  |           |        |
| Test        | 13703      | 10985 (80,16 %) | 2718 (19,84 %) | 80,51 %  |           |        |

