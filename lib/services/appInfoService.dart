
import 'package:rayanSchool/models/AppInfo/News.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/models/AppInfo/newsDetails.dart';
import 'package:rayanSchool/models/AppInfo/sliderPhotos.dart';
import 'package:rayanSchool/models/AppInfo/subject.dart';
import 'package:rayanSchool/models/AppInfo/subjectDetails.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';
import '../models/school_policies_details_model.dart';
import '../models/school_policies_model.dart';
import '../models/school_social_media_link_model.dart';

class AppInfoService {

  final ApiService api = ApiService();
  // Fetch slider photos with enhanced error handling and logging
  Future<List<SliderData>> getSliderPhotos() async {
    try {
      final data = await api.request(Services.sliderLink,"GET");

      if (data is List) {
        return data
            .map((e) => SliderData.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ SliderData error: $e");
      return [];
    }

  }
// Fetch about school information with enhanced error handling and logging
  Future<AboutSchool?> getAboutSchool() async {
    try {
      final data = await api.request(Services.aboutSchool,"GET",);

      if ( data.isNotEmpty) {
        return AboutSchool.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getAboutSchool error: $e");
      return null;
    }

  }
  // Fetch school policy information with enhanced error handling and logging
  Future<AboutSchool?> getSchoolPolicy() async {
    try {
      final data = await api.request(Services.schoolPolicyUrl,"GET",);

      if ( data.isNotEmpty) {
        return AboutSchool.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getActivitiesDetails error: $e");
      return null;
    }

  }
// Fetch school word information with enhanced error handling and logging
  Future<AboutSchool?> getSchoolWord() async {
    try {
      final data = await api.request(Services.schoolWord,"GET",);

      if ( data.isNotEmpty) {
        return AboutSchool.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getSchoolWord error: $e");
      return null;
    }

  }
// Fetch about app information with enhanced error handling and logging
  Future<AboutSchool?> getaboutApp() async {
    try {
      final data = await api.request(Services.aboutApp,"GET",);

      if ( data.isNotEmpty) {
        return AboutSchool.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getaboutApp error: $e");
      return null;
    }

  }
// Fetch privacy policy information with enhanced error handling and logging
  Future<AboutSchool?> getPrivacyPolicy() async {
    try {
      final data = await api.request(Services.privacyPolicy,"GET",);

      if ( data.isNotEmpty) {
        return AboutSchool.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getPrivacyPolicy error: $e");
      return null;
    }
  }
  // Fetch school social media link information with enhanced error handling and logging
  Future<SchoolSocialMediaLinkModel?> getSchoolSocialMediaLink() async {
    try {
      final data = await api.request(Services.schoolSocialMediaLink,"GET",);

      if ( data.isNotEmpty) {
        return SchoolSocialMediaLinkModel.fromJson(data);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getSchoolSocialMediaLink error: $e");
      return null;
    }

  }

  Future<List<Subjects>?> getSubjects() async {
    try {
      final data = await api.request(Services.subjects,"GET");

      if (data is List) {
        return data
            .map((e) => Subjects.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSubjects error: $e");
      return [];
    }

  }
  Future<List<SchoolPoliciesModel>?> getSchoolPolicies() async {
    try {
      final data = await api.request(Services.schoolPolices,"GET",queryParameters:{
        "id":"762"
      });

      if (data is List) {
        return data
            .map((e) => SchoolPoliciesModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSchoolPolicies error: $e");
      return [];
    }

  }

  Future<List<SubjectDetails>> getSubjectDetails({String? id}) async {
    try {
      final data = await api.request(Services.subjectsDetails,"GET",queryParameters:{
        "dep_id":id
      });

      if (data is List) {
        return data
            .map((e) => SubjectDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSubjectDetails error: $e");
      return [];
    }

  }
  Future<List<SchoolPoliciesDetailsModel>> getSchoolPoliciesDetails({String? id}) async {
    try {
      final data = await api.request(Services.schoolPoliciesDetails,"GET",queryParameters:{
        "arts_id":id
      });

      if (data is List) {
        return data
            .map((e) => SchoolPoliciesDetailsModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSchoolPoliciesDetails error: $e");
      return [];
    }

  }

  Future<List<News>?> getNews() async {

    try {
      final data = await api.request(Services.news,"GET");

      if (data is List) {
        return data
            .map((e) => News.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getNews error: $e");
      return [];
    }

  }

  Future<List<NewsDetails>> getNewsDetails({String? id}) async {
    try {
      final data = await api.request(
          Services.newsDetails, "GET", queryParameters: {
        "news_id": id
      });

      if (data is List) {
        return data
            .map((e) => NewsDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getNewsDetails error: $e");
      return [];
    }
  }
}
