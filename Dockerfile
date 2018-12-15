FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# build folder will be created in the WORKDIR (so path='/app/build', is where we'll have the stuff we care about and want to copy over during our "run phase")

FROM nginx    
# (you can think of as) FROM statement terminates the previous block
EXPOSE 80 
# 'EXPOSE': this does nothing automatically normally, but AWS elasticbean will look for this instruction, and map directly automatially
COPY --from=builder /app/build /usr/share/nginx/html



