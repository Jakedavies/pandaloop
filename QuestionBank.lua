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
    "Alright then! So, what you are looking at at the top of your screen is a for loop. Hopefully you have seen one in class, but if not that is totally fine!",
    --Multiple Choice Questions
     {
        false,
        "Very cool unknown wizard",
     },
     --Correct Answer? 0 For Tutorial
     {2},
     --Question Feedback
     {
        false,
        false,
        "I said you had free choice, not that it was the right answer..."
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
        "i++",
        "Got it! Lets learn more!"
     },
     --Correct Answer? 0 For Tutorial
     {4},
     --Question Feedback
     {
        "So this is the declaration, here we are declaring a variable i, that is initially instantiated to 0.",
        "This is what gets evaluated at the TOP of every loop, before it executes, here we are making sure that the variable i is less than 4. So this loop will loop 4 times, i = 0, i = 1, i = 2, and i = 3. Because it is LESS THAN it only runs 4 times, not 5.",
        "I said you had free choice, not that it was the right answer...",
        false,
     },
 }
}