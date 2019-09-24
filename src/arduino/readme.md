# Arduino code for control the agrobot:

  * This code allows arduino to receive information (Uart Communication) and transmit to Hover MainBoard (I2C Communication)
  
# Protocol for send uart to the arduino:

 * Are three varaible that control the mainBoard(hoverBoard):
     * Speed
     -> Steer
     -> Limit
     
  * speed accept values from -100 to 100.
     -> 0 is means stopped
     -> 100 means al power to front
     -> -100 means al power to behind
  
   * Steer accept values from -100 to 100.
     -> 0 is means front
     -> 100 means turn right
     -> -100 means turn left behind
     
   * Limit is a speed coefficient
 
 # Receiving values via Uart:
  
  * The procotol implemented is: ABCD;ABCD;ABCD;
 
  * ABCD are numbers:
    -> the number A is the signal, if its 1 the singnal is +, else its 0 the signal is -
    -> BCD are the numbers who define the speed, steer and limit values, from 0 to 100
    ->Examples:
         send 80 in speed and turn full right, without limit:
          1080;1100;1100;
  
