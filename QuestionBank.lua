--The Final Question must be an empty one. 
Questions = {
    {
    --Main Question [1]
    "For centuries, there have been those who seek to capture the great panda. Do you have what it takes?",
    --Tutorial Bubble [2]
    "Psst... Down here. Long ago a transdimensional panda visited our world. He knows only darkness and chaos. You look like a Garry to me. I will call you Garry."  ,
    --Multiple Choice Questions [3]
     {
        "You bet!",
        "It is my destiny...",
        "This is what I have been training for.",
        "Well, none of these are no..."
     },
     --Correct Answer? 0 For Tutorial [4]
     {0},
     --Question Feedback [5]
     {
        false,
        false,
        false,
        false
     }
    },
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "Would you like to learn about for loops?",
    --Tutorial Bubble
    "You're a wizard Garry. You can stop this transdimensional panda by trapping him in a for loop. You do know about those right? They are like, basic wizard stuff...",
    --Multiple Choice Questions
     {
        false,
        false,
        "Yes. Tell me more..",

     },
     --Correct Answer? 0 For Tutorial
     {3},
     --Question Feedback
     {
        false,
        false,
        false
     }
    },
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "for(int i = 0; i < 4; i++){\n doWizardStuff(); \n} ",
    --Tutorial Bubble
    "Alright then! So, what you are looking at at the top of your screen is a for loop. Hopefully you have seen one in class, but if not that is totally fine! You really can choose, 'this is boring' go on, do it...",
    --Multiple Choice Questions
     {
        false,
        "Very cool unknown wizard",
        "This is boring"
     },
     --Correct Answer? 0 For Tutorial
     {2},
     --Question Feedback
     {
        false,
        false,
        "I said you had free choice, not that it was the right answer... this stuff IS cool, deal with it, admit it, and click the right answer..."
     }
    },
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "for(int i = 0; i < 4; i++){\n doWizardStuff(); \n} ",
    --Tutorial Bubble
    "For loops are pretty simple, the stuff in the brackets is what gets evaluated to keep the loop running, between the curly braces is what gets executed each loop. Click to learn more!",
    --Multiple Choice Questions
     {
        "int i = 0;",
        "i < 4;",
        "Got it! Lets learn more!",
        "i++",
     },
     --Correct Answer? 0 For Tutorial
     {3},
     --Question Feedback
     {
        "So this is the declaration, here we are declaring a variable i, that is initially instantiated to 0.",
        "This is what gets evaluated at the TOP of every loop, before it executes, here we are making sure that the variable i is less than 4. So this loop will loop 4 times, i = 0, i = 1, i = 2, and i = 3. Because it is LESS THAN it only runs 4 times, not 5.",
        false,
        "At the end of every loop we increment i by one, hence the i++.",
     }
    },
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "Are you ready to face, the panda?",
    --Tutorial Bubble
    "All that you have to do to face the panda is to answer some simple questions for me. They really are no big deal. ",
    --Multiple Choice Questions
     {
        false,
        "Okay tiny wizard man, let's do this",
        "I don't want to do this...",
        false,
     },
     --Correct Answer? 0 For Tutorial
     {2},
     --Question Feedback
     {
        false,
        false,
        "You have to be prepared to face the panda. You must master for loops...",
        false,
     }
    },
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "Which of these is correct in syntax?",
    --Tutorial Bubble
    "Alrighty then, if you are so smart, which one of these is correct? Seriously I need to know, I have wizard homework, and believe me it's hard. It is due like yesterday so chop chop...",
    --Multiple Choice Questions
     {
        false,
        "for[var k : k > 10 : k+]{ \n youMayPass(); \n}",
        "for(int i = 0; i < 10; i ++){ \n doWizardStuff(); \n}",
        false,
     },
     --Correct Answer? 0 For Tutorial
     {3},
     --Question Feedback
     {
        false,
        "Not even close I am afraid. Thanks, I failed the assignment... apparently for loops use ( and ) for brackets, not [ and ]",
        false,
        false,
     }
    },
     --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "for(int i = 0; i < 10; i ++){ \n doWizardStuff(); \n arrivePrecisleyWhenIMeanTo(); \n i -= 1; \n inventory[i] = i+1; \n}",
    --Tutorial Bubble
    "Okay, so you managed to do my homework... I mean answer my riddle, once. The next question is hard. Tell me what is wrong in this for loop...",
    --Multiple Choice Questions
     {
        "doWizardStuff()",
        "arrivePrecisleyWhenIMeanTo()",
        "i-=1",
        "inventory[i] = i+1",
     },
     --Correct Answer? 0 For Tutorial
     {3},
     --Question Feedback
     {
        "No, this is just calling a function every time the loop runs. ",
        "No, this is just calling a function every time the loop runs. I am a fan of this actually, a wizard always does this...",
        false,
        "We are just incrementing whatever is stored in the inventory by i's value here. This is fine.",
     }
    },
     --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "for(int i = 0; i < 9001; i ++){ \n ItsOverNineThousannnd(); \n DateTime t = getTime(); \n} \n dinnerReservations(t);",
    --Tutorial Bubble
    "Okay, so you managed to do my homework... I mean answer my riddle, once. The next question is hard. Tell me what is wrong with this for loop...",
    --Multiple Choice Questions
     {
        "Nothing. That code is perfect.",
        "There is a scope issue.",
        " i++",
        "It can not be over nine thousand.",
     },
     --Correct Answer? 0 For Tutorial
     {2},
     --Question Feedback
     {
        "There is in fact a mistake in the code. Have another look!",
        false,
        "i++ increments the count on i at the bottom of every for loop. ",
        "Goku proves you wrong.",
     }
    },
      --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||| NEW QUESTION |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    --||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    {
    --Main Question
    "Ready to face the panda!?",
    --Tutorial Bubble
    "Okay, so you have finished all of my wizard homework. I suppose that I will let you face the panda. It was nice knowing you!!.... I mean, I am positive that you have what it takes...",
    --Multiple Choice Questions
     {
        false,
        "Let's do this!",
     },
     --Correct Answer? 0 For Tutorial
     {0},
     --Question Feedback
     {
        false,
        false,
     }
    },
    
}