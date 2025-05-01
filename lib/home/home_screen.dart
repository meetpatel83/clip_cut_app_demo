import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/routes/routes_name.dart';
import '../model/pet_entity/pet_data_list.dart';
import '../model/pet_entity/pet_model.dart';
import '../services/session_manager/session_controller.dart';
import '../services/storage/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24), // spacing after drag handle

              const Text(
                'Are you sure you want to\n logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Raleway",
                  letterSpacing: 1,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // No Button
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          LocalStorage localStorage = LocalStorage();
                          localStorage.clearValue('token').then((value) {
                            localStorage.clearValue('isLogin');
                            Navigator.pushNamed(
                              context,
                              RoutesName.login,
                            ); // Navigating to the login screen after clearing token and isLogin value
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(53),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Yes Button
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff004961),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: "Raleway",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), // curved edges
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 14,
          ), // center text vertically
          suffixIcon: SizedBox(
            height: 24,
            width: 24,
            child: Padding(
              padding: const EdgeInsets.all(
                8.0,
              ), // optional, centers the icon better
              child: Image.asset(
                "images/search.png",
                color: Color(0xffBFBFBF),
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
          hintText: 'Search by name or pet ID',
          hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: "Raleway",
            color: Color(0xff000000),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCardPet(PetModel pet) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circle Image
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: pet.bgColor.withBlue(1)),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: pet.bgColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(pet.imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              // Name & ID Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          pet.petName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: "Raleway",
                          ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 7.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffDEE5FF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7.0,
                                vertical: 3.0,
                              ),
                              child: Text(
                                pet.petGender,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Color(0xff6B8CFF),
                                  fontFamily: "Raleway",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${pet.id.toString().padLeft(4, '0')}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff888888),
                        fontFamily: "Raleway",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Divider(color: Colors.grey.withOpacity(.3)),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mating Date Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mating Date',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff999999),
                        fontFamily: "Raleway",
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pet.matingDate,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ],
                ),
              ),
              // Breeding Partner Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Breeding Partner',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff999999),
                        fontFamily: "Raleway",
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pet.breedingPartner,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ],
                ),
              ),
              // Pregnancy Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pregnancy',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff999999),
                        fontFamily: "Raleway",
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pet.pregnancy,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white
      appBar: AppBar(
        toolbarHeight: 98,
        backgroundColor: const Color(0xff00B4BF),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar on the left
            SizedBox(
              width: 60,
              height: 60,
              child: ClipOval(
                child: Image.asset(
                  'images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Text(
                  'ClipCuts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Pattaya",
                  ),
                ),
              ),
            ),

            // Logout icon on the right
            IconButton(
              onPressed: () {
                showLogoutBottomSheet(context);
              },
              icon: Image.asset('images/logout.png', color: Colors.white),
            ),
          ],
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: dummyPetData.length,
                itemBuilder: (context, index) {
                  return _buildCardPet(dummyPetData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
