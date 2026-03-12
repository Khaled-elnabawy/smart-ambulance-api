from datetime import datetime
import mysql.connector
from sklearn.cluster import KMeans
import numpy as np

# Database connection
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',
    database='smart_ambulance'
)

cursor = conn.cursor()


cursor.execute("""
    SELECT pickup_latitude, pickup_longitude
    FROM requests
    WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)
""")

requests = cursor.fetchall()

if len(requests) < 3:
    print("Not enough data for clustering")
    exit()

coords = np.array(requests)


k = min(3, len(coords))
kmeans = KMeans(n_clusters=k, random_state=42)
labels = kmeans.fit_predict(coords)
centers = kmeans.cluster_centers_


cluster_demand = {i:0 for i in range(k)}

for label in labels:
    cluster_demand[label] += 1


cursor.execute("""
    SELECT 
        COALESCE(home_latitude, last_latitude) as latitude,
        COALESCE(home_longitude, last_longitude) as longitude
    FROM drivers
    WHERE last_latitude IS NOT NULL
    AND last_longitude IS NOT NULL
""")

drivers = cursor.fetchall()


recommendations = []

for i in range(k):

    lat, lon = centers[i]

    demand = cluster_demand[i]

    ambulances = 0

    for dlat, dlon in drivers:
        dlat = float(dlat)
        dlon = float(dlon)

        if abs(dlat - lat) < 0.02 and abs(dlon - lon) < 0.02:
            ambulances += 1

    score = demand / (ambulances + 1)

    recommendations.append((lat, lon, score))


cursor.execute("DELETE FROM ambulance_recommendations")

for lat, lon, score in recommendations:

    cursor.execute("""
        INSERT INTO ambulance_recommendations
        (latitude, longitude, score, created_at)
        VALUES (%s,%s,%s,%s)
    """, (lat, lon, score, datetime.now()))

conn.commit()


print(f"✓ AI recommendations generated for {len(recommendations)} areas")

for lat, lon, score in recommendations:

    if score > 2:
        level = "HIGH PRIORITY"
    elif score > 1:
        level = "MEDIUM PRIORITY"
    else:
        level = "LOW PRIORITY"

    print(f"Area ({lat:.4f},{lon:.4f}) | Score {score:.2f} | {level}")

cursor.close()
conn.close()