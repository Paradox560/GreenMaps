import json

# Load the annotations
with open('tf-trash-detection/data/annotations.json') as f:
    data = json.load(f)

# Get the specific annotations
annotation_309 = next((item for item in data['annotations'] if item["id"] == 309), None)
annotation_309_2 = next((item for item in data['annotations'] if item["id"] == 309), None)
annotation_4040 = next((item for item in data['annotations'] if item["id"] == 4040), None)
annotation_4040_2 = next((item for item in data['annotations'] if item["id"] == 4040), None)

# Check if the annotations refer to the same object in the same image
if annotation_309 and annotation_309_2:
    if annotation_309['bbox'] == annotation_309_2['bbox'] and annotation_309['image_id'] == annotation_309_2['image_id']:
        print("Annotations 309 and 309_2 refer to the same object in the same image.")
    else:
        print("Annotations 309 and 309_2 do not refer to the same object in the same image.")

if annotation_4040 and annotation_4040_2:
    if annotation_4040['bbox'] == annotation_4040_2['bbox'] and annotation_4040['image_id'] == annotation_4040_2['image_id']:
        print("Annotations 4040 and 4040_2 refer to the same object in the same image.")
    else:
        print("Annotations 4040 and 4040_2 do not refer to the same object in the same image.")