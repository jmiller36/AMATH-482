#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.metrics import confusion_matrix


# In[2]:


fashion_mnist = tf.keras.datasets.fashion_mnist
(X_train_full, y_train_full), (X_test, y_test) = fashion_mnist.load_data()


# In[3]:


X_train_full.shape


# In[4]:


plt.figure()
for k in range(9):
    plt.subplot(3,3,k+1)
    plt.imshow(X_train_full[k], cmap="gray")
    plt.axis('off')
plt.show()


# In[5]:


X_valid = X_train_full[:5000] / 255.0
X_train = X_train_full[5000:] / 255.0
X_test = X_test / 255.0

y_valid = y_train_full[:5000]
y_train = y_train_full[5000:]


# In[6]:


model = tf.keras.models.Sequential([
    tf.keras.layers.Flatten(input_shape=[28,28]),
    tf.keras.layers.Dense(300, activation="relu", kernel_regularizer=tf.keras.regularizers.l2(.0001)),
    tf.keras.layers.Dense(100, activation="relu", kernel_regularizer=tf.keras.regularizers.l2(.0001)),
    tf.keras.layers.Dense(10, activation="softmax", kernel_regularizer=tf.keras.regularizers.l2(.0001))
])


# In[7]:


model.compile(loss="sparse_categorical_crossentropy",
             optimizer=tf.keras.optimizers.Adam(learning_rate=.0001),
             metrics=["accuracy"])


# In[8]:


y_train_full[:9]


# In[9]:


history = model.fit(X_train, y_train, epochs=5, validation_data=(X_valid, y_valid))


# In[10]:


pd.DataFrame(history.history).plot(figsize=(8,5))
plt.grid(True)
plt.gca().set_ylim(0,1)
plt.ylabel('Percent')
plt.xlabel('Epoch')
plt.title('Model Performance')
plt.show()


# In[11]:


y_pred = model.predict_classes(X_train)
conf_train = confusion_matrix(y_train, y_pred)
print(conf_train)


# In[12]:


model.evaluate(X_test, y_test)

