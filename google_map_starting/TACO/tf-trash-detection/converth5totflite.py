import os
import tensorflow as tf

# Specify the path to your .h5 model
model_path = '/mnt/c/Users/rohan/Documents/GreenMaps/TACO/tf-trash-detection/model.h5'

# Check if the model file exists
if not os.path.exists(model_path):
    raise Exception(f"Model file {model_path} does not exist")

# Load the Keras model
model = tf.keras.models.load_model(model_path)

# Create a converter
converter = tf.lite.TFLiteConverter.from_keras_model(model)

# Convert the model
tflite_model = converter.convert()

# Save the TFLite model to a .tflite file
with open('model.tflite', 'wb') as f:
    f.write(tflite_model)