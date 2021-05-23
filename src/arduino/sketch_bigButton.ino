const int buttonPin = 5;
const int ledPin =  7;

int button_value = 1;
int button_value_prev = 1;


void setup() 
{
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);

  Serial.begin(9600);
  while (!Serial);
  Serial.println("ready");
}



void loop() 
{
  button_value_prev = button_value;
  button_value = digitalRead(buttonPin);

  if(button_value_prev!=button_value)
  {
    if(button_value==HIGH)
    {
      Serial.println("up");
    }else
    {
      Serial.println("down");
    }
  }

  if(button_value == HIGH) 
  {
    digitalWrite(ledPin, HIGH);
  }else 
  {
    digitalWrite(ledPin, LOW);
  }

  delay(10);//needed to avoid false positive

}
