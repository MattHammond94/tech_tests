# Breakdown:

- Each frame consists of a max of 2 rolls 

- EXCEPT frame 10 which has a max of 3

- If the player hits a strike on roll one (10) the frame ends.

Bonus':

> Strike: 
> the bonus for this frame will be the total number of pins knocked down over the next 2 ROLLS (meaning the next frame unless another strike is hit.)

> Spare:
> A spare is if 10 pins are knocked down in 2 rolls.
> Bonus for this is the first roll of the next frame. 

> Gutter: 
> Player doesn't hit a single pin. 0 points.

> Perfect:
> 12 strikes. (10 reg strikes and 2 in the bonus.) 300 points.

> 10th frame: 
> Strike or spare rolled on 10th frame then they can roll the remaining bonus rolls (2 if strike - 1 if spare.)

# Plan

@current_frame = 0
@total_score = 0
@active_frame_score = 0
@strike_round? = false
@spare_round = false

```A frame``` => Takes two args (roll, score) => (1, 5)

### Errors/edgecases: 
if !roll.is_a?(Integer) => ArgumentError
if @current_frame != 10 && roll > 2 => Error - Can't have more than 2 roles on a non final frame.
if @current_frame == 10 && roll > 3 => Error - Can't have more than 3 roles on a final game.

### Logic:
if score == 10 && roll == 1 => ```Strike``` => ```@strike_round``` = true

if @strike_round => do strike round logic then set strike_round as false => both rolls of next set added to bonus

if score > 10 => ```normal roll``` => increment active_frame_score

if score + @active_frame_score == 10 => ```Spare``` => ```@spare_round``` = true

if @spare_round => Do spare round logic then set spare_round as false 

if @current_frame == 10 => Final frame - Reset frame count after bonus rounds.

### Breakdown 

On initialization of the class the ```current_frame``` will be set at 0

Each frame will be ended (after all other logic has been run) by increasing the current_frame.

Once the 10 frames have been played this count will be reset (because this game is over.)

if a spare_round or a strike_round are active then the bonus will be applied to the overall score. 

A strike will apply bonus(the score for the frame) to the ```@total_score``` for both the the rolls in the frame.

In the case of a spare however bonus will only be applied when the frames roll is 1. 

both will be defined as private functions (strike and spare) which will be run when their corresponding instance variable is set to true.
