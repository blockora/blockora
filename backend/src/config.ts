export const cfg = {
  port: process.env.PORT || 8080,
  serverUrl: process.env.SERVER_URL!,          // <-- TODO (Hindi): backend URL
  mongo: process.env.MONGODB_URI,              // optional
  jwtPrivatePem: process.env.JWT_PRIVATE_PEM!, // <-- TODO (Hindi): PEM
  attestorPublicAddress: process.env.ATTESTOR_PUBLIC_ADDRESS || "",
};
