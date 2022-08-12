
  /*******************************************************************************
  ECON 120B, Spring 2022
  Stata Assignment 2
  Name: Bryan Lee
  PID: A17238775
  *******************************************************************************/
  clear all // clear the environment/memory
  set more off
  sysuse nlsw88 // load the built-in dataset nlsw88

****1*****
*a
gen lnwage=ln(wage)*100 
regress lnwage grade ttl_exp tenure, robust
*  8.050632, 1.211481 
*b
test ttl_exp==3 
*t statistic is 10.66
*Since P-Value is 0.8945, which is greater than 0.1, we do not reject the null hypothesis.

gen grade_squared= grade*grade //this is so we can estimate the new model with grade^2 variable

reg lnwage grade ttl_exp tenure grade_squared, robust 

*c
*beta1hat is 3.770023, 95% confidence interval= -.4452366    7.985282
*d
*beta4hat is .1624159. The p-value is 0.053 > 0.05 and so we do not reject the 
*null hypothesis at 5% significance level. And because we do not reject the null
*at 5%, we also do not reject the null at 10% significance level.
*e
disp 3.770023*1 + .1624159*1 //3.9324389
*f
reg lnwage grade grade_squared, robust //Bonferroni statistic= 3.29, 2 restrictions,
*p-val=0, so we reject null hypothesis at 5% significance level

***2***
*a
tab occupation // freq. of sales= 32.45% = 0.3245
*b
tab occupation, nolabel //numeric value that correspond to Sales is 3
*c
summarize wage if occupation==3 // 7.154489
*d
regress wage i.occupation, robust // professional/technical is the base group because
*it correspond to the numeric value 1. 
disp 10.72362 -3.569135 // mean sales is 7.154485
*e
*Managers/Admin
disp  10.72362+.1761604 //avg wage for Mangers/Admin is 10.89978
*f
regress hours i.occupation, robust // Managers/Admin work longest hours per week
disp  37.76025+5.228341 //42.988591 hours is the hours per week Managers/Admin spend working

*g
regress wage i.race //Other is White in this case, since there are only Black or White race in the variable race
disp  8.082999+.4677818 // 8.5507808 is the average wage for White people
*h
disp 8.082999-1.238442 //6.844557 is the average wage for Black people
disp 8.5507808-6.844557 //1.7062238 is the wage gap for the two races
*Left hand side of 95% CI
disp 1.7062238-1.96*10.28 //-18.442576
*i
tab race
tab race, nolabel
sum wage if race==1 //8.082999 is the avg wage for White People, this is less than in part g

******3******
gen union_collgrad= union*collgrad
reg wage union collgrad union_collgrad
*a
* The base category are people NOT a collgrad and NOT in a union
*6.36869 avg wage for base category
*b
disp 1.454899 //  1.454899 this is the difference.
*c
disp 1.454899 + 3.748679 -1.098846 // the difference is 4.104732
*d
gen union_ttl_exp = union*ttl_exp
reg lnwage union ttl_exp union_ttl_exp

*4.966676 is the avg percentage change for non-unionized workers for 1 years increase of exp
disp 4.966676-1.133489 //3.833187 is the answer. We do not need to think aboout the union term because we are only asked of the percentage change















