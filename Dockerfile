FROM node:25-alpine AS build-stage
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npx parcel build "./src/index.html" --dist-dir "./dist" --public-url "./" \
&& npx parcel build "./src/feedback.html" --dist-dir "./dist" --public-url "./"


FROM nginx:1.29.3-alpine
COPY --from=build-stage /app/dist/ /usr/share/nginx/html