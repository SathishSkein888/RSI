var housingData = {
  "title": "2.HOUSING",
  "question": [
    {
      "qus": "1.Type of House? ",
      "type": "radio",
      "choices": [
        "Semi Pukka House",
        "Pukka House",
        "Kaccha House",
        "Individual House",
        "Apartment"
      ],
      "ans": ""
    },
    {
      "qus": "2. Number of Floors",
      "type": "radio",
      "choices": [
        "Single Storied (G+0)",
        "Two Storied (G+1)",
        "3 Storied (G+2)",
        "Multi Storied (G+3 and above)"
      ],
      "ans": ""
    },
    {
      "qus": "3.Material used in Structure",
      "type": "subqus",
      "subqunts": [
        {
          "qus": "a.Wall",
          "type": "radioWithText",
          "subqus": false,
          "choices": ["Brick/ Stone", "Mud blocks/Bamboo", "Others, Specify:"],
          "ans": ""
        },
        {
          "qus": "b. Roof",
          "type": "radioWithText",
          "subqus": false,
          "choices": ["RCC", "Tin", "Tiles", "Others, Specify:"],
          "ans": ""
        }
      ]
    },
    {
      "qus": "4. Age of House:",
      "type": "radio",
      "choices": [
        "0 - 5 Yrs.",
        "5 -15 Yrs",
        "15 – 25 Yrs. ",
        "More than 25 yrs."
      ],
      "ans": ""
    },
    {
      "qus": " 5. House condition",
      "type": "radio",
      "choices": ["Good", "Average", "Poor"],
      "ans": ""
    },
    {
      "qus": "6.Ownership type",
      "type": "radio",
      "choices": ["Self-owned ", "Rented"],
      "ans": ""
    },
    {
      "qus": "if rented, amount:",
      "type": "textnumber",
      "choices": [],
      "ans": ""
    },
    {
      "qus": "7.Land Ownership",
      "type": "radio",
      "choices": ["Self-owned ", "Government"],
      "ans": ""
    },
    {
      "qus": "8.Approx. price range of land (per Katha): Rs.",
      "type": "textnumber",
      "choices": [],
      "ans": ""
    },
    {
      "qus": "9. Do you have any other land Property?",
      "type": "radio",
      "choices": ["Yes", "No"]
    },
    {"qus": "If yes, Where?", "type": "text", "choices": [], "ans": ""},
    {
      "qus": "If No, Are you willing to buy?",
      "type": "radio",
      "choices": ["Yes", "No"],
      "ans": ""
    },
    {
      "qus": "10. Usage of Residential Building (Observe & Tick)",
      "type": "checkbox1",
      "choices": [
        "Self Use",
        "Rent purpose",
        "Shop/Commercial",
        "Manufacturing Activity",
        "Government Office",
        "Private Office",
        "Other Specify:"
      ],
      "ans": ""
    },
    {
      "qus": "11. Asset owned by Household",
      "type": "checkbox",
      "selected": [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ],
      "choices": [
        "Refrigerator",
        "Telephone / Mobile Phone",
        "Computer / Laptop",
        "Television",
        "A.C",
        "Geyser",
        "Electric Mixer / Grinder",
        "Washing Machine",
        "Tape Recorder / CD player"
      ],
      "ans": ""
    },
    {
      "qus": "12. Cooking fuel used in the kitchen",
      "type": "radioWithText",
      "choices": [
        "Cooking Gas / LPG",
        "Firewood",
        "Electric Induction",
        "Kerosene",
        "Cooking Coal",
        "If Other, Specify: "
      ],
      "ans": ""
    }
  ]
};
