from kwcoco import CocoDataset

# Load the dataset
coco_ds = CocoDataset('tf-trash-detection/data/annotations.json')

unique_annotations = {}

for ann in coco_ds.anns.values():
    # Use a tuple of the annotation values as the key
    key = (ann['image_id'], ann['category_id'], tuple(ann['bbox']))
    if key not in unique_annotations:
        unique_annotations[key] = ann

# Create a new CocoDataset object
new_coco_ds = CocoDataset()

# Add the unique annotations to the new CocoDataset object
for ann in unique_annotations.values():
    # Ensure that the 'image_id' field is an integer
    ann['image_id'] = int(ann['image_id'])
    new_coco_ds.add_annotation(ann)

# Save the new dataset back to the JSON file
new_coco_ds.dump('tf-trash-detection/data/annotationsnew.json')