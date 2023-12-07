import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';
import { getStorage } from 'firebase/storage';

const firebaseConfig = {
  apiKey: "AIzaSyAQB6F6a8IdPrMbZAxJVEHqCeSWlHRkAg0",
  authDomain: "nuparent.firebaseapp.com",
  projectId: "nuparent",
  storageBucket: "nuparent.appspot.com",
  messagingSenderId: "605899779488",
  appId: "1:605899779488:web:066298cc86835a6e0fc8c5",
  measurementId: "G-BZ9C20HXN9"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);
