import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sowlabapp/auth/LoginPage/login_page.dart';
import 'package:sowlabapp/auth/SignUp/sign_up_1_page.dart';
import 'package:sowlabapp/onboarding_segment/onboardmodel.dart';

final onboardingData = [
  OnboardModel(
    image: "assets/onboarding_1.svg",
    title: "Quality",
    description:
        "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain. ",
    backgroundColor: const Color(0xff5ea25f),
  ),
  OnboardModel(
    image: "assets/onboarding_2.svg",
    title: "Convenient",
    description:
        "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers.",

    backgroundColor: const Color(0xffd5715b),
  ),
  OnboardModel(
    image: "assets/onboarding_3.svg",
    title: "Local",
    description:
        "We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time. ",
    backgroundColor: const Color(0xfff8c569),
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

PageController _pageController = PageController();

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onboardingData[currentIndex].backgroundColor,
      body: Center(
        child: Stack(
          children: [
            // TOP IMAGE
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                onboardingData[currentIndex].image,
                height: MediaQuery.of(context).size.height * 0.50,
                fit: BoxFit.fill,
              ),
            ),

            // BOTTOM CARD
            Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomCard()),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              final item = onboardingData[index];

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Be Vietnam",
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 300, // tweak this for perfect match
                    child: Text(
                      item.description,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: "Be Vietnam"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        _buildDots(),

        SizedBox(height: 60),

        _buildButton(),

        SizedBox(height: 20),

        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          ),
          child: Text(
            "Login",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: "Be Vietnam",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCard() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.47,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: _buildPageContent(),
    );
  }

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SignUpPage(registrationData: {})),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: onboardingData[currentIndex].backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Text(
                "Join the movement!",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
