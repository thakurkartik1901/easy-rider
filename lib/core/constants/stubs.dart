class Stubs {
  Stubs._(); //this is to prevent anyone from instantiating this object

  static const dataUI = {
    'driver': {
      "user": "Ram Singh",
      "phone": "(+91) 9090909090",
      "current_status": "Online",
      "profile_pic":
          "https://images.pexels.com/photos/3252086/pexels-photo-3252086.jpeg?cs=srgb&dl=pexels-mohamadreza-mohamadi-3252086.jpg&fm=jpg",
    }
  };

  static const user = {
    "name": "Ram Singh",
    "phone": "(+91) 9090909090",
    "current_status": "Offline",
    "profile_pic":
        "https://images.pexels.com/photos/3252086/pexels-photo-3252086.jpeg?cs=srgb&dl=pexels-mohamadreza-mohamadi-3252086.jpg&fm=jpg",
  };

  static const customer = {
    "name": "Avinash Sachdeva",
    "phone": "(+91) 9090909090",
  };
  static const customer2 = {
    "name": "Riya Jain",
    "phone": "(+91) 9090909090",
  };
  static const pickup = {
    "address": "Star Mall Sector 30, NH-8, Gurugram, Haryana 122001",
    "latitude": 37.4221681,
    "longitude": -122.16763
  };
  static const drop = {
    "address":
        "NH- 8, Ambience Island, DLF Phase 3, Sector 24, Gurugram, Haryana 122002",
    "latitude": 37.4221681,
    "longitude": -122.16763
  };
  static const rides = [
    {
      "id": 2,
      "customer": Stubs.customer2,
      "pickup": Stubs.pickup,
      "drop": Stubs.drop,
      "pickupTime": "2017-08-26",
      "startTime": "2017-08-26",
      "status": 1
    },
    {
      "id": 1,
      "customer": Stubs.customer,
      "pickup": Stubs.pickup,
      "drop": Stubs.drop,
      "pickupTime": "2024-01-15T18:13:46.701779",
      "status": 0
    },
    // {
    //   "id": 3,
    //   "customer": Stubs.customer,
    //   "pickup": Stubs.pickup,
    //   "drop": Stubs.drop,
    //   "pickupTime": "2017-08-26",
    //   "startTime": "2017-08-26",
    //   "endTime": "2022-05-25",
    //   "status": 3
    // }
  ];
}
