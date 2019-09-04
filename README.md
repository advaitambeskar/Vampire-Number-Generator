# Distributed Operating Systems by Dr. Alin Dobra
## Project 1 – Vampire Numbers
## Group
* Aotian Wu (5139-4302)
* Advait Ambeskar (9615-9178)

## Requirements
Use the [link](https://elixir-lang.org/install.html) to install Elixir which is a hard requirement for this project.

## Instructions
> Unzip the file (project1.zip)

```shell
cd working-directory
cd Project1
```
```elixir
mix run proj1.exs <number 1> <number2>
```

## Questions
#### Number of Actors Created
```
16
```
#### Size of the work unit of each worker actor that you determined results in best performance for your implementation and an explanation on how you determined it. Size of the work unit refers to the number of sub-problems that a worker gets in a single request from the boss.
```
Less than (total range/16)
```
#### The result of running your program for: mix run proj1.exs 100000 200000
| Results | | |
| :---------- | :------------: | -----------:|
| 102510 201 510 | 140350 350 401 | 105210 210 501 |
| 163944 396 414 | 104260 260 401 | 129640 140 926 |
| 120600 201 600 | 153436 356 431 | 180225 225 801 |
| 115672 152 761 | 131242 311 422 | 126027 201 627 |
| 152685 261 585 | 145314 351 414 | 193257 327 591 |
| 136948 146 938 | 172822 221 782 | 133245 315 423 |
| 190260 210 906 | 182250 225 810 | 105750 150 705 |
| 134725 317 425 | 174370 371 470 | 182650 281 650 |
| 125248 152 824 | 108135 135 801 | 116725 161 725 |
| 156915 165 951 | 126846 261 486 | 146137 317 461 |
| 123354 231 534 | 186624 216 864 | 175329 231 759 |
| 173250 231 750 | 105264 204 516 | 162976 176 926 |
| 192150 210 915 | 125500 251 500 | 125433 231 543 |
| 197725 275 719 | 193945 395 491 | 146952 156 942 |
| 156289 269 581 | 135828 231 588 | 136525 215 635 |
| 152608 251 608 | 118440 141 840 | 129775 179 725 |
| 156240 240 651 | 135837 351 387 | 110758 158 701 |
| 125460 204 615 246 510 | 117067 167 701 | 132430 323 410 |
| 124483 281 443 | 150300 300 501 | 180297 201 897 |

This is just a representation of the result. The result is stored at [\project1\documentation\result.txt](.\project1\documentation\result.txt “Result is copied to this file to be displayed easily)


### Report the running time for the above problem (4).
(Image Here!)
**Ratio : User/ Real = 1.9454**
### The largest problem you managed to solve
We ran the code for all 10 digits numbers. It took __more than 33 minutes__ but we found __all__ the 10 digit vampire numbers. So the largest 10-digit vampire number **(9953948970)** is the largest number we encountered.

(Image here!) 

**Ratio: User/ Real = 11801178/2035635 = 5.7972**

### You could also inspect your code with observer
We could not use observer.start() for the range 100000 to 200000, so we used the same function for 10000000 to 20000000 and have attached the output that we observed

(Image here!)

## Program Structure
This is the image description for the modules that we have designed and written.

(Image Here!)
## Contributing
Since this is a private repository intended to serve as a backup for the project as required by the course, pull requests would not be welcome unless authorized by the members of the public. This may change after the submission is complete.

## License
[MIT](https://choosealicense.com/licenses/mit/)