int main(int argc, char* argv) {
   setuid(0);
   system("/home/amnesia/Persistent/.securedrop-airgap/init.sh");
   return 0;
}
