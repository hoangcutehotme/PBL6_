import 'dart:convert';

class Detection {
    String? id;
    String? date;
    String? description;
    List<dynamic>? detections;
    String? image;
    String? name;

    Detection({
        this.id,
        this.date,
        this.description,
        this.detections,
        this.image,
        this.name,
    });

    factory Detection.fromJson(String str) => Detection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Detection.fromMap(Map<String, dynamic> json) => Detection(
        id: json["_id"],
        date: json["date"],
        description: json["description"],
        detections: List<dynamic>.from(json["detections"].map((x) => x)),
        image: json["image"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "date": date,
        "description": description,
        "detections": List<dynamic>.from(detections!.map((x) => x)),
        "image": image,
        "name": name,
    };
}
