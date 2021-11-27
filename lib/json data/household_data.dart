var questionData = {
  "title": "1. HOUSEHOLD PROFILE",
  "question": [
    {
      "qus": "1. Migrated?",
      "type": "radio",
      "choices": ["Yes", "No"],
      "ans": "",
      "selected": false
    },
    {
      "qus": "If Yes, No.of Years?",
      "type": "radio",
      "choices": [
        "> 5 Year",
        "5 to 10 Years",
        "10 to 25 Years",
        "25 to 50 Years",
        "< 50 Years"
      ],
      "ans": "",
      "selected": false
    },
    {
      "qus": "If migrated:",
      "type": "subqus",
      "subqunts": [
        {
          "qus": "A. Place of Origin",
          "type": "radio",
          "subqus": false,
          "choices": ["Within State", "Outside State"],
          "ans": "",
          "selected": false
        },
        {
          "qus": "B. Migration type:",
          "type": "radio",
          "subqus": false,
          "choices": ["Seasonal", "Permanent"],
          "ans": "",
          "selected": false
        },
        {
          "qus": "C. Reason of migration:",
          "type": "radiowithtext",
          "subqus": false,
          "choices": [
            "Education",
            "Employment",
            "Living Condition",
            "Accessibility",
            "If Other, Specify"
          ],
          "ans": "",
          "selected": false
        }
      ],
      "choices": [],
    },
    {
      "qus": "2. Are you willing to migrate to another place?",
      "type": "radiowithtext",
      "choices": [
        "Yes",
        "No",
        "Maybe",
        "If yes or maybe Place / Location"
      ],
      "ans": "",
      "selected": false
    },
    {
      "qus": "If No, Reasons for not going back to the native place?",
      "type": "radiowithtext",
      "choices": [
        "Earning Money",
        "Habituated",
        "Education",
        "If other, Specify"
      ],
      "ans": "",
      "selected": false
    },
    {
      "qus":
          "3. After the covid-19 situation, are you willing to go back to your native place?",
      "type": "radio",
      "choices": ["Yes", "No"],
      "ans": "",
      "selected": false
    }
  ]
};
