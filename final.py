import speech_recognition as sr
import pyttsx3 
r=sr.Recognizer()
with sr.Microphone() as source:
    print("Hey There!")
    print("Welcome to First Aid Bot")
    print("Tell Us What Happened")
    print("We Would be Really Happy To Help You")
    audio=r.listen(source)
    print("Thanks! Processing in Process.....................")
data=r.recognize_google(audio)
if(("hurt" in data) or ("damage" in data)  or ("blood" in data) or ("bleeding" in data)) :
        pyttsx3.speak("Don't worry you will be alright just follow below procedures")
        print("You need a bandage and then you will be alright.")
elif((("attack" in data) or ("heart attack" in data) or ("heart pain" in data))):
        pyttsx3.speak("Have the person sit down, rest, and try to keep calm. Loosen any tight clothing. Ask if the person takes any chest pain medicine, such as nitroglycerin, for a known heart condition, and help them take it.")
        pyttsx3.speak("Don't worry you will be alright just follow below procedures")
elif("Thanks" in data) or ("Thank you" in data):
        print("It's was our pleasure to help you!!")
        pyttsx3.speak("Don't worry you will be alright just follow below procedures")
        
else:
        pyttsx3.speak("Please contact your nearest doctor")
        print("---------------------------------------")
       
        print("---------------------------------------")

